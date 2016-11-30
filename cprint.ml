open Cparse
open Format

let print_declarations out dec_list =
  Format.fprintf out "Todo\n"

let print_locator out nom fl fc ll lc =
  Format.fprintf out "Todo\n"

let print_ast out dec_list =
  Format.fprintf out "Todo\n"

(* let ident ppf s = (fprintf ppf "%s" s)
let kwd ppf s = (fprintf ppf "[%s]" s)

let rec pr_exp0 ppf = function
  | Var s -> fprintf ppf "%a" ident s
  | lam -> fprintf ppf "@[<1>(%a)@]" pr_lambda lam
and pr_app ppf e =
  fprintf ppf "@[<hov 10>%a@]" pr_other_applications e
and pr_other_applications ppf f =
  match f with
  | Apply (f, arg) -> fprintf ppf "%a@ %a" pr_app f pr_exp0 arg
  | f -> pr_exp0 ppf f
and pr_declaration ppf = function
  | CDECL(_, str) ->
    fprintf ppf "@[<1>%a%a@]"
      kwd "VAR" ident str
  | CFUN(_, str, decl_list, (_, code)) -> (
      fprintf ppf "@[<1>%a%a%a@ %a@]" kwd "FUN" ident str kwd " : ";
      List.iter pr_declaration decl_list)
  | e -> pr_app ppf e
 *)