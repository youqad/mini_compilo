open Cparse
open Genlab
open List

module Function = struct
  type t = string * int
  let compare = Pervasives.compare
end


module StringMap = Map.Make(String)

module FunMap = Map.Make(Function)

(*  1. first round : Using Maps to store the labels of global variables and functions
    2. second round : Using another Map to store the labels of strings
    3. third round : (the core of the function)
        - printing the .data (strings and global variables) section
        - compiling the inner code of global functions,
          with resort to "compile_code" and "compile_expr" *)

let compile out decl_list =
  let arguments_registers = [|"%rdi"; "%rsi"; "%rdx"; "%rcx"; "%r8"; "%r9"|] in
  let functions_64b = ["malloc"; "calloc"; "realloc"; "exit"] in
  (* first round : a Map is used to store the labels of global variables (resp. functions)
     in the environment of variables (resp. functions)  *)
  let add_gdecl_to_envs (env_gvar, env_fun) = function
    | CDECL(_, str) -> (StringMap.add str str env_gvar, env_fun)
    | CFUN(_, str, dec_list, _) -> (
        (* a function is identified by its name and its number of arguments.
           The case of two different functions having the same name but distinct
            numbers of arguments is tackled *)
        let exists_already = FunMap.exists (fun (stri, nb_args) value ->
            if stri = str then
              true
            else
              false
          ) env_fun in
        let functionLabel = if exists_already then genlab str else str in
        (env_gvar, FunMap.add (str, length dec_list) functionLabel env_fun)
      ) in

  let env_var, env_fun = fold_left add_gdecl_to_envs (StringMap.empty, FunMap.empty) decl_list in

  (* second round : a Map is used to store the labels of strings
     in a string environment *)
  let rec add_str_to_env_from_decl env = function
    | CDECL(_) -> env
    | CFUN(_, str, dec_list, (_, code)) -> add_str_to_env_from_code env code

  and add_str_to_env_from_code env = function
    | CBLOCK(_, loc_code_list) -> fold_left add_str_to_env_from_code env (snd (List.split loc_code_list))
    | CEXPR(_, expr) -> add_str_to_env_from_expr env expr
    | CIF((_, expr1), (_, code1), (_, code2)) -> let env' = add_str_to_env_from_expr env expr1 in
      fold_left add_str_to_env_from_code env' [code1; code2]
    | CWHILE((_, expr), (_, code)) -> let env' = add_str_to_env_from_expr env expr in
      add_str_to_env_from_code env' code
    | CRETURN(loc_expr_option) -> (match loc_expr_option with
      | Some (_, expr) -> add_str_to_env_from_expr env expr
      | None -> env)
    | CTHROW(str, (_, expr)) -> add_str_to_env_from_expr (StringMap.add str (genlab "exception") env) expr
    | CTRY((_, code), str_str_locCode_list, loc_code_option) -> (let env2 = add_str_to_env_from_code env code in
      let env3 = fold_left (fun env' (str,_,(_,code')) -> add_str_to_env_from_code (StringMap.add str (genlab "exception") env') code') env2 str_str_locCode_list in
      (match loc_code_option with
       | Some (_, code') -> add_str_to_env_from_code env3 code'
       | None -> env3)
      )
  and add_str_to_env_from_expr env = function
    | STRING(str) -> StringMap.add str (genlab "string") env
    | VAR(_) | CST(_) -> env
    | SET_VAR(_, (_, expr)) | OP1(_, (_, expr)) -> add_str_to_env_from_expr env expr
    | SET_ARRAY(_, (_, expr1), (_, expr2)) | OP2(_, (_, expr1), (_, expr2)) | CMP(_, (_,expr1), (_, expr2)) -> fold_left add_str_to_env_from_expr env [expr1; expr2]
    | EIF((_, expr1), (_, expr2), (_, expr3)) -> fold_left add_str_to_env_from_expr env [expr1; expr2; expr3]
    | CALL(_, loc_expr_list) | ESEQ(loc_expr_list) -> fold_left add_str_to_env_from_expr env (snd (List.split loc_expr_list)) in

  let env_strings = fold_left add_str_to_env_from_decl (StringMap.empty) decl_list in
  let exception_not_caught = (genlab "exception_not_caught") in
  (
    (* Firstly : printing the data section *)
    Printf.fprintf out ".data\n\n";

    (* declaring strings *)
    StringMap.iter (fun key_string associated_label -> Printf.fprintf out "%s:\n\t.asciz %S\n\t.align 8\n" associated_label key_string) env_strings;

    Printf.fprintf out "\n\n";

    (* declaring global variables *)
    StringMap.iter (fun key_var associated_label -> Printf.fprintf out ".comm %s,8,8\n" associated_label) env_var;

    (* declaring the global variable used as a flag "exception_not_caught" *)
    Printf.fprintf out ".comm %s,8,8\n" exception_not_caught;

    (* Secondly : printing the text section *)

    Printf.fprintf out "\n\n.text\n\n";

    (* initializing to false the global variable used as a flag "exception_not_caught" *)
    Printf.fprintf out "\tmovq $0, %s\n" exception_not_caught;


    (* The tricky part : compiling functions *)

    (* an auxiliary function to compile the code within global functions *)
    let rec compile_code current_fun endFunctionLabel is_in_finally finallyLabel env_var env_exceptions offset_local_vars = function
      | CBLOCK(dec_list, loc_code_list) -> let nb_local_vars = length dec_list in
        (
          (* First :
             - allocating space of the stack for local variables declared in dec_list
             - adding them to the variable environment
             - modifying the variable containing their offset relatively to %rbp  *)
          if nb_local_vars > 0 then Printf.fprintf out "\tsubq $%d, %%rsp\n" (nb_local_vars*8);
          let new_env_var, new_offset_local_vars =
            fold_left (fun (env, offset) decl -> let str_offset = (string_of_int (offset-8)) ^ "(%rbp)" in
                      match decl with
                      | CDECL(_, str) -> (StringMap.add str str_offset env, offset-8)
                      | CFUN(_) -> (env, offset)
                      ) (env_var, offset_local_vars) dec_list in

          (* recursively applying compile_code the code list until a "RETURN" statement is reached *)
          let _ = fold_left (fun reached_return code -> match (reached_return, code) with
                      | (true, _) -> true
                      | (_, (CRETURN(_) as code_return)) -> (
                          compile_code current_fun endFunctionLabel is_in_finally finallyLabel new_env_var env_exceptions new_offset_local_vars code_return;
                          true
                        )
                      | (_, other_code) -> (
                          compile_code current_fun endFunctionLabel is_in_finally finallyLabel new_env_var env_exceptions new_offset_local_vars other_code;
                          false
                        )
                  ) false (snd (List.split loc_code_list)) in ();

          (* balancing the stack *)
          if nb_local_vars > 0 then Printf.fprintf out "\taddq $%d, %%rsp\n" (nb_local_vars*8)
          )
      | CEXPR(_, expr) -> compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr
      | CIF((_, expr), (_, code1), (_, code2)) -> (
          compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr;

          (* comparing expr to zero *)
          Printf.fprintf out "\tcmpq $0, %%rax\n";

          (* two labels are used :
             - failureIf for the "else" branch
             - endIf for the end of the "if statement" *)
          let endIf = (genlab (current_fun^"_endIf")) and failureIf = (genlab (current_fun^"_failureIf")) in
          (
            Printf.fprintf out "\tje %s\n" failureIf;
            compile_code current_fun endFunctionLabel is_in_finally finallyLabel env_var env_exceptions offset_local_vars code1;
            Printf.fprintf out "\tjmp %s\n" endIf;
            Printf.fprintf out "%s:\n" failureIf;
            compile_code current_fun endFunctionLabel is_in_finally finallyLabel env_var env_exceptions offset_local_vars code2;
            Printf.fprintf out "%s:\n" endIf;
          )
        )
      | CWHILE((_, expr), (_, code)) ->
        (* two labels are used :
           - loopWhile for core of the loop
           - endWhile for the end of the "while statement" *)
        let endWhile = (genlab (current_fun^"_endWhile")) and loopWhile = (genlab (current_fun^"_loopWhile")) in
          (
            Printf.fprintf out "%s:\n" loopWhile;
            compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr;
            (* compare expr to zero *)
            Printf.fprintf out "\tcmpq $0, %%rax\n";
            Printf.fprintf out "\tje %s\n" endWhile;
            compile_code current_fun endFunctionLabel is_in_finally finallyLabel env_var env_exceptions offset_local_vars code;
            Printf.fprintf out "\tjmp %s\n" loopWhile;
            (* end while *)
            Printf.fprintf out "%s:\n" endWhile;
          )
      | CRETURN(loc_expr_option) -> (
          if is_in_finally then
            Printf.fprintf out "\tmovq $0, %s\n" exception_not_caught;
          (match loc_expr_option with
              | Some (_, expr) -> compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr
              | None -> ());

          (* when a "return statement" is reached : one quits the function *)
          (match finallyLabel with
          | Some str_finally -> Printf.fprintf out "\tjmp %s\n" str_finally
          | None -> ());

          Printf.fprintf out "\tjmp %s \t# return reached : end function\n" endFunctionLabel
        )
      | CTHROW(str, (_, expr)) -> (
        let is_known = StringMap.mem str env_exceptions in
        let exceptionLabel = if is_known then StringMap.find str env_exceptions
          else (match finallyLabel with
                None -> endFunctionLabel
              | Some str_finally -> str_finally) in
            (
              if not is_known then
                Printf.fprintf out "\tmovq $1, %s\n" exception_not_caught
              else
                Printf.fprintf out "\tmovq $0, %s\n" exception_not_caught;

              compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr;
              let stri = StringMap.find str env_strings in
                Printf.fprintf out "\tmovq $%s, %%rcx\n" stri;
              Printf.fprintf out "\tjmp %s \t# exception thrown \n" exceptionLabel
            )
        )
      | CTRY((_, code), str_str_locCode_list, loc_code_option) -> let continueLabel = genlab (current_fun^"tryContinue") and beginLabel = genlab (current_fun^"tryBegin") in
        (
          Printf.fprintf out "\tjmp %s\n" beginLabel;
          let new_finallyLabel = match loc_code_option with
            | Some (_, code') -> let new_label = genlab (current_fun^"finally") in (
                Printf.fprintf out "%s:\n" new_label;
                compile_code current_fun endFunctionLabel true finallyLabel env_var env_exceptions offset_local_vars code';
                Printf.fprintf out "\tjmp %s \t# end of finally reached \n" continueLabel;
                Some new_label
              )
            | None -> None in

          let new_env_exceptions = fold_left (fun env (str_excep, str_var, (_,code')) ->
              let exceptionLabel = (genlab (current_fun^"_"^str_excep^"_exception")) in
              (
                Printf.fprintf out "%s:\n" exceptionLabel;
                Printf.fprintf out "\tmovq $0, %s\n" exception_not_caught;

                Printf.fprintf out "\tsubq $8, %%rsp\n";
                let str_offset = (string_of_int (offset_local_vars-8)) ^ "(%rbp)" in
                let new_env_var = StringMap.add str_var str_offset env_var in
                (
                  Printf.fprintf out "\tmovq %%rax, %s\n" str_offset;
                  compile_code current_fun endFunctionLabel is_in_finally new_finallyLabel new_env_var env_exceptions (offset_local_vars-8) code';
                  (match new_finallyLabel with
                    | Some str_finally -> Printf.fprintf out "\tjmp %s\n" str_finally
                    | None -> Printf.fprintf out "\tjmp %s\n" continueLabel);
                );
                StringMap.add str_excep exceptionLabel env;
              )) env_exceptions str_str_locCode_list in
          (
            Printf.fprintf out "%s:\n" beginLabel;
            compile_code current_fun endFunctionLabel is_in_finally new_finallyLabel env_var new_env_exceptions offset_local_vars code;
            (match new_finallyLabel with
              | Some str_finally -> Printf.fprintf out "\tjmp %s\n" str_finally
              | None -> ());
            (* end Try Block *)
            Printf.fprintf out "%s:\n" continueLabel;
          )
        )
    and compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars = function
      | VAR(str) ->
        (* two cases :
           - the variable is either already in the variable environment
           - or it is a C global variable *)
        let is_known = StringMap.mem str env_var in
          let var = if is_known then StringMap.find str env_var else str in
            Printf.fprintf out "\tmovq %s, %%rax\n" var
      | CST(num) -> Printf.fprintf out "\tmovq $%d, %%rax\n" num;
      | STRING(str) -> let stri = StringMap.find str env_strings in
        Printf.fprintf out "\tmovq $%s, %%rax\n" stri
      | SET_VAR(str, (_, expr)) -> (
        compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr;
        let var = StringMap.find str env_var in
          Printf.fprintf out "\tmovq %%rax, %s\n" var;
        )
      | SET_ARRAY(str, (_, expr1), (_,expr2)) -> (
          compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr2;
          Printf.fprintf out "\tpushq %%rax\n";
          compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions (offset_local_vars-8) expr1;
          Printf.fprintf out "\tpopq %%rcx\n";
          (* expr1 is now in %rax, expr2 in %rcx *)


          let my_array = StringMap.find str env_var in
            Printf.fprintf out "\tmovq %s, %%rdx\n" my_array;

          Printf.fprintf out "\tmovq %%rcx, (%%rdx, %%rax, 8)\n";

          (* putting expr2 in %rax to return it *)
          Printf.fprintf out "\tmovq %%rcx, %%rax\n";
        )
      | CALL(str, loc_expr_list) -> let number_of_args = length loc_expr_list in
        (* three bottom lines :
           - managing arguments
           - checking out the function name
           - checking alignment before call *)

        (* is the stack pointer 16-byte aligned,
           knowing that the base pointer %rbp isn't ? (because of calle-saved registers before) *)
        let is_aligned = (-offset_local_vars/8 mod 2 = 1) in
        let fixed_alignment = ref 0 in (
          if ((max 0 (number_of_args-6)) mod 2) = 0 then (
            if not is_aligned then
              (
                Printf.fprintf out "\tsubq $8, %%rsp\t# to align the stack on a 16B boundary\n";
                fixed_alignment := 1;
              )
          )
          else if is_aligned then (
            Printf.fprintf out "\tsubq $8, %%rsp\t# to align the stack on a 16B boundary\n";
            fixed_alignment := 1;
          );

          (* saving caller-saved registers *)
          Printf.fprintf out "\tpushq %%r10\t# save caller-saved registers\n\tpushq %%r11\n";

          (* Firstly : put all the arguments on stack *)
          let new_offset_local_vars = offset_local_vars - 16 - !fixed_alignment*8 in
          iteri (fun i expr -> (
                    compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions new_offset_local_vars expr;
                    Printf.fprintf out "\tpushq %%rax\t# putting argument number %d on the stack\n" (number_of_args - i)
                  )
            ) (rev (snd (List.split loc_expr_list)));

          (* Now : store the min(number_of_args, 6) first arguments in the appropriate registers *)
          Array.iteri (fun i register -> if i < number_of_args then (
                    Printf.fprintf out "\tpopq %s" register;
                    Printf.fprintf out "\t# putting argument number %d in register\n" (i+1);
                  )
            ) arguments_registers;

          (* set %rax to 0, because the calling convention requires %rax to indicate
             the number of vector registers used, for variable argument functions (such as "printf") *)
          Printf.fprintf out "\txorq %%rax, %%rax\n";

          (* two cases :
             - the function is either already in the function environment
             - or it is a C build-in function :
                - in that case, if the function name isn't in the functions_64b vector,
                  one must convert the output from 32b to 64b *)
          let is_known = FunMap.mem (str, number_of_args) env_fun in
          let fun_label = if is_known then FunMap.find (str, number_of_args) env_fun else str in
          (
            Printf.fprintf out "\tcallq %s\n" fun_label;
            if not is_known && not (mem fun_label functions_64b) then
              Printf.fprintf out "\tcltq\n";
          );

          (* retrieve caller-saved registers *)
          Printf.fprintf out "\tpopq %%r10\t# retrieve caller-saved registers\n\tpopq %%r11\n";

          (* balancing the stack *)
          if !fixed_alignment=1 then
            Printf.fprintf out "\taddq $8, %%rsp\t# to restore the stack alignment\n";


            (* compare exception_not_caught to 0 *)
          Printf.fprintf out "\tcmpq $0, %s\n" exception_not_caught;

          let endExceptionCaught = (genlab (current_fun^"_endExceptionCaught")) in
          (
            Printf.fprintf out "\tje %s\n" endExceptionCaught;

            (* if an exception has been caught *)
            StringMap.iter (fun str_excep excep_label ->
                (
                  let stri = StringMap.find str_excep env_strings in
                  Printf.fprintf out "\tmovq $%s, %%rdx\n" stri;

                  Printf.fprintf out "\tcmpq %%rcx, %%rdx\n";
                  Printf.fprintf out "\tje %s\n" excep_label;
                )
              ) env_exceptions;

            Printf.fprintf out "\tjmp %s\n" (match finallyLabel with
                                            | Some str_finally -> str_finally
                                            | None -> endFunctionLabel);

            Printf.fprintf out "%s:\n" endExceptionCaught;
          )

        )
      | OP1(mon_op, (_, expr)) -> let op, is_post, modifies_variable = match mon_op with
          | M_MINUS -> "neg", 0, false
          | M_NOT -> "not", 0, false
          | M_POST_INC -> "inc", 1, true
          | M_PRE_INC -> "inc", 0, true
          | M_POST_DEC -> "dec", 1, true
          | M_PRE_DEC -> "dec", 0, true in (

          if (not modifies_variable) || (match expr with VAR(_) -> true | _ -> false) then (

            compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr;

            (* the value of expr is stored in for later, if needed *)
            if is_post=1 then Printf.fprintf out "\tpushq %%rax\t# the value of expr is stored in for later\n";

            Printf.fprintf out "\t%s %%rax\n" op
          );

          (* When it comes to Inc/Dec : the l-value must also be modified *)
          if modifies_variable then (
            match expr with
            | VAR(str) ->  let var = StringMap.find str env_var in
                Printf.fprintf out "\tmovq %%rax, %s\n" var
            | OP2(bin_op, (_, e1), (_,e2)) when bin_op = S_INDEX ->(
              (* the l-value is ensured to be at most a one dimensional access to an array *)
                match e1 with
                | VAR  (str) -> let my_array = StringMap.find str env_var in (

                    compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars e2;
                    (* e2 in %rax *)

                    Printf.fprintf out "\tmovq %s, %%rdx\n" my_array;

                    Printf.fprintf out "\tmovq (%%rdx, %%rax, 8), %%rcx\n";

                    (* the value of expr is stored in for later, if needed *)
                    if is_post=1 then Printf.fprintf out "\tpushq %%rcx\t# the value of expr is stored in for later\n";

                    Printf.fprintf out "\t%s %%rcx\n" op;

                    Printf.fprintf out "\tmovq %%rcx, (%%rdx, %%rax, 8)\n";

                    Printf.fprintf out "\tmovq %%rcx, %%rax\n"
                  )
                | _ -> failwith "Error OP2")
            | _ -> ());

          (* for POST INC/DEC : return the previous value of expr *)
          if is_post=1 then Printf.fprintf out "\tpopq %%rax\n";
        )
      | OP2(bin_op, (_, expr1), (_, expr2)) ->(
        compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr2;
        Printf.fprintf out "\tpushq %%rax\n";
        compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions (offset_local_vars-8) expr1;
        Printf.fprintf out "\tpopq %%rcx\n";
        match bin_op with
        | S_MUL | S_ADD | S_SUB -> (
            let op = match bin_op with
              | S_MUL -> "imulq"
              | S_ADD -> "addq"
              | S_SUB -> "subq"
              | _ -> failwith "Error while compiling OP2" in
           Printf.fprintf out "\t%s %%rcx, %%rax\n" op
          )
         | S_DIV | S_MOD -> (
            Printf.fprintf out "\txorq %%rdx, %%rdx\n\tcqo\n\tidivq %%rcx\n";
            match bin_op with  S_MOD -> Printf.fprintf out "\tmovq %%rdx, %%rax\n"
                              | _ -> ()
            )
         | S_INDEX -> (match expr1 with
             | VAR(str) -> let my_array = StringMap.find str env_var in (
                 compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr2;
                 Printf.fprintf out "\tmovq %%rax, %%rcx\n";
                 Printf.fprintf out "\tmovq %s, %%rdx\n" my_array;
                 Printf.fprintf out "\tmovq (%%rdx, %%rcx, 8), %%rax\n"
               )
            | OP2(bin_op', (_, expr1'), (_, expr2')) as expr' when bin_op' = S_INDEX -> (
                (* multi-dimensional access to an array *)
                compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr2;
                Printf.fprintf out "\tpushq %%rax\n";
                compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions (offset_local_vars-8) expr';
                Printf.fprintf out "\tpopq %%rcx\n";
                Printf.fprintf out "\tmovq %%rax, %%rdx\n";
                Printf.fprintf out "\tmovq (%%rdx, %%rcx, 8), %%rax\n"
              )
            | _ -> ()
           )
        )
      | CMP(cmp_op, (_,expr1), (_, expr2)) -> (
          compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr2;
          Printf.fprintf out "\tpushq %%rax\n";
          compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions (offset_local_vars-8) expr1;
          Printf.fprintf out "\tpopq %%rcx\n";
          let op = (match cmp_op with
            | C_LT -> "jl"
            | C_LE -> "jle"
            | C_EQ -> "je") in
          (* two labels are used :
             - successCmp if the comparison is successful
             - continueCmp for the end of the "comparison expression" *)
            let successCmp = (genlab (current_fun^"_successCmp")) and continueCmp = (genlab (current_fun^"_continueCmp")) in
          (
            Printf.fprintf out "\tcmpq %%rcx, %%rax\n";
            Printf.fprintf out "\t%s %s\n" op successCmp;
            Printf.fprintf out "\txorq %%rax, %%rax\n";
            Printf.fprintf out "\tjmp %s\n" continueCmp;
            Printf.fprintf out "%s:\n\tmovq $1, %%rax\n" successCmp;
            Printf.fprintf out "%s:\n" continueCmp;
          )
        )
      | EIF((_, expr1), (_, expr2), (_, expr3)) -> (
          compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr1;

          (* compare expr to zero *)
          Printf.fprintf out "\tcmpq $0, %%rax\n";

          let endIf = (genlab (current_fun^"_endIf")) and failureIf = (genlab (current_fun^"_failureIf")) in
          (
            Printf.fprintf out "\tje %s\n" failureIf;
            compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr2;
            Printf.fprintf out "\tjmp %s\n" endIf;
            Printf.fprintf out "%s:\n" failureIf;
            compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars expr3;
            (* end if *)
            Printf.fprintf out "%s:\n" endIf;
          )
        )
      | ESEQ(loc_expr_list) -> iter (compile_expr current_fun endFunctionLabel finallyLabel env_var env_exceptions offset_local_vars) (snd (List.split loc_expr_list))
    in

    (* iterating over global functions to apply compile_code *)
    let iter_over_functions = function
      | CDECL(_, str) -> ()
      | CFUN(_, str, dec_list, (_, code)) -> let nb_args = length dec_list in
        let fun_label = FunMap.find (str, nb_args) env_fun in
        (
          Printf.fprintf out ".globl %s\n %s:\n" fun_label fun_label;

          (* saving the callee-saved registers *)
          Printf.fprintf out "\tpushq %%rbx\t# saving callee-saved registers\n\tpushq %%r12\n\tpushq %%r13\n\tpushq %%r14\n\tpushq %%r15\n";

          (* initializing the base pointer *)
          Printf.fprintf out "\tpushq %%rbp\t# base pointer\n\tmovq %%rsp, %%rbp\n";

          (* - putting register-stored arguments on the stack
             - adding reference to the argument variables in the variable environment,
              by storing their position relative to %rbp *)
          let new_env_var, _ =
            fold_left (fun (env, var_number) decl -> match decl with
                | CDECL(_, str) -> if var_number < 7 then
                    let offset = -8*var_number in
                    (
                      Printf.fprintf out "\tpushq %s\t# saving argument number %d on the stack\n" (arguments_registers.(var_number-1)) var_number;
                      (StringMap.add str ((string_of_int offset)^"(%rbp)") env, var_number+1)
                    )
                  else
                    let offset = (8*6+8*(var_number-6)) in
                    (StringMap.add str ((string_of_int offset)^"(%rbp)") env, var_number+1)
                | _ -> (env, var_number)
              ) (env_var, 1) dec_list in

            (* a label to reach the end of the function in case of "return statement" *)
            let endFunctionLabel = (genlab (fun_label^"_endFunction")) in
              (
                compile_code fun_label endFunctionLabel false None new_env_var (StringMap.empty) (-(min nb_args 6)*8) code;
                Printf.fprintf out "%s:\n" endFunctionLabel;

                (* restoring callee-saved registers, and %rbp *)
                Printf.fprintf out "\tmovq %%rbp, %%rsp\n\tpopq %%rbp\n";
                Printf.fprintf out "\tpopq %%r15\t# restoring callee-saved registers\n\tpopq %%r14\n\tpopq %%r13\n\tpopq %%r12\n\tpopq %%rbx\n";
                Printf.fprintf out "\tretq\n";
              )
        )
       in
    iter iter_over_functions decl_list
  )

(* debugging tool :
   if not (StringMap.mem str env_strings) then (let str_err = (StringMap.fold (fun key value s -> (s^"-"^key)) env_strings "") in failwith ("Erreur 175 ! "^str_err) )
   else
*)


(*

Exceptions :

  1) get the names of exceptions
  2)

*)
