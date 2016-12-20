// Some tests for C--
// Written by Laurent Prosperi, ENS Cachan, in 2015.

#ifndef MCC
#include <stdio.h>
#include <stdlib.h>
#endif

int test_throw(){
	throw E 25;
	printf("failed, test_throw\n");
	return;
}

int do_nothing(){
	int i;
	i=5;
	return i;
}

int test_call(){
	test_throw();
	printf("failed, test_call\n");
}


int test_try_no_excep_no_finally_no_return(){
	try{
		do_nothing();
		printf("pass, test_try_no_excep_no_finally_no_return 1\n");
	}catch( Ex e){
		printf("failed, test_try_no_excep_no_finally_no_return 1\n");
		do_nothing();
	}catch( Ex1 e){
		printf("failed, test_try_no_excep_no_finally_no_return 2\n");
		do_nothing();
	}
	printf("pass, test_try_no_excep_no_finally_no_return 2\n");
}


int aux_try_no_excep_no_finally_return(){
	try{
		do_nothing();
		return 5;
	}catch( Ex e){
		printf("failed, test_try_no_excep_no_finally_return 1\n");
		do_nothing();
	}catch( Ex1 e){
		printf("failed, test_try_no_excep_no_finally_return 2\n");
		do_nothing();
	}
	printf("failed, test_try_no_excep_no_finally_return 3\n");
}

int test_try_no_excep_no_finally_return(){
	if( aux_try_no_excep_no_finally_return() == 5){
		printf("pass, test_try_no_excep_no_finally_return 1\n");
	}else{
		printf("failed, test_try_no_excep_no_finally_return 4\n");
	}
}


int test_try_no_excep_finally_no_return(){
	try{
		do_nothing();
		printf("pass, test_try_no_excep_finally_no_return 1\n");
	}catch( Ex e){
		printf("failed, test_try_no_excep_finally_no_return 1\n");
		do_nothing();
	}catch( Ex1 e){
		printf("failed, test_try_no_excep_finally_no_return 2\n");
		do_nothing();
	}finally{
		do_nothing();
		printf("pass, test_try_no_excep_finally_no_return 2\n");
	}
	printf("pass, test_try_no_excep_finally_no_return 3\n");
}


int aux_try_no_excep_finally_return(){
	try{
		do_nothing();
		printf("pass, test_try_no_excep_finally_return 1\n");
		return 5;
	}catch( Ex e){
		printf("failed, test_try_no_excep_finally_return 2\n");
		do_nothing();
	}catch( Ex1 e){
		printf("failed, test_try_no_excep_finally_return 3\n");
		do_nothing();
	}finally{
		do_nothing();
		printf("pass, test_try_no_excep_finally_return 2\n");
	}
	printf("failed, test_try_no_excep_finally_return 4\n");
	return 0;
}

int test_try_no_excep_finally_return(){
	if( aux_try_no_excep_finally_return() == 5)
		printf("pass, test_try_no_excep_finally_return 3\n");
	else
		printf("failed, test_try_no_excep_finally_return 5\n");
}


int aux_try_no_excep_finally_return_2(){
	try{
		do_nothing();
		printf("pass, aux_try_no_excep_finally_return_2 1\n");
		return 5;
	}catch( Ex e){
		printf("failed, aux_try_no_excep_finally_return_2 1\n");
		do_nothing();
	}catch( Ex1 e){
		printf("failed, aux_try_no_excep_finally_return_2 2\n");
		do_nothing();
	}finally{
		do_nothing();
		printf("pass, aux_try_no_excep_finally_return_2 2\n");
		return 3;
	}
	printf("failed, test_try_no_excep_finally_return 3\n");
	return 0;
}

int test_try_no_excep_finally_return_2(){
	if( aux_try_no_excep_finally_return_2() == 3)
		printf("pass, aux_try_no_excep_finally_return_2 3\n");
	else
		printf("failed, aux_try_no_excep_finally_return_2 4\n");
}


int aux_try_no_excep_finally_return_3(){
	try{
		do_nothing();
		printf("pass, aux_try_no_excep_finally_return_3 1\n");
		return 5;
	}catch( Ex e){
		printf("failed, aux_try_no_excep_finally_return_3 1\n");
		do_nothing();
	}catch( Ex1 e){
		printf("failed, aux_try_no_excep_finally_return_3 2\n");
		do_nothing();
	}finally{
		do_nothing();
		printf("pass, aux_try_no_excep_finally_return_3 2\n");
		throw Stop(0);
	}
	printf("failed, aux_try_no_excep_finally_return_3 3\n");
	return 0;
}

int test_try_no_excep_finally_return_3(){
	try{
		aux_try_no_excep_finally_return_3();
	}catch( Stop e){
		printf("pass, aux_try_no_excep_finally_return_3 3\n");
		return 0;
	}
	printf("failed, aux_try_no_excep_finally_return_3 4\n");
}


int aux_try_excep_finally_return_no_handler(){
	try{
		do_nothing();
		throw E1( 5 );
		printf("failed, test_try_excep_finally_return_no_handler 1\n");
		return 1;
	}catch( E2 e){
		do_nothing();
		printf("failed, test_try_excep_finally_return_no_handler 2\n");
	}finally{
		printf("pass, test_try_excep_finally_return_no_handler 1\n");
		do_nothing();
		return 9;
	}
	return -1;
}

int test_try_excep_finally_return_no_handler(){
	if( aux_try_excep_finally_return_no_handler() == 9)
		printf("pass, aux_try_excep_finally_return_no_handler 2\n");
	else
		printf("failed, aux_try_excep_finally_return_no_handler 3\n");
}


int aux_try_excep_finally_return_handler(){
	try{
		do_nothing();
		throw E5( 5 );
		printf("failed, aux_try_excep_finally_return_handler 1\n");
		return 5;
	}catch( E1 e){
		do_nothing();
		printf("failed, aux_try_excep_finally_return_handler 2\n");
	}
	catch( E2 e){
		do_nothing();
		printf("failed, aux_try_excep_finally_return_handler 3\n");
	}
	catch( E5 e){
		do_nothing();
		printf("pass, aux_try_excep_finally_return_handler 1\n");
	}
	catch( E3 e){
		do_nothing();
		printf("failed, aux_try_excep_finally_return_handler 4\n");
	}finally{
		printf("pass, aux_try_excep_finally_return_handler 2\n");
		do_nothing();
	}
	return -1;
}

int test_try_excep_finally_return_handler(){
	if( aux_try_excep_finally_return_handler() == -1)
		printf("pass, test_try_excep_finally_return_handler 3\n");
	else
		printf("failed, test_try_excep_finally_return_handler 5\n");
}


int aux_try_excep_in_catch(){
	try{
		do_nothing();
		throw E5( 5 );
		printf("failed, aux_try_excep_in_catch 1\n");
		return 5;
	}catch( E1 e){
		do_nothing();
		printf("failed, aux_try_excep_in_catch 2\n");
	}
	catch( E2 e){
		do_nothing();
		printf("failed, aux_try_excep_in_catch 3\n");
	}
	catch( E5 e){
		do_nothing();
		printf("pass, aux_try_excep_in_catch 1\n");
		throw E20 (21569);
		printf("failed, aux_try_excep_in_catch 4\n");
	}
	catch( E3 e){
		do_nothing();
		printf("failed, aux_try_excep_in_catch 5\n");
	}finally{
		printf("failed, aux_try_excep_in_catch 6\n");
		do_nothing();
	}
	return -1;
}

int test_try_excep_in_catch(){
	try{
		aux_try_excep_in_catch();
		printf("failed, aux_try_excep_in_catch 7\n");
	}catch( E20 e){
		printf("pass, aux_try_excep_in_catch 2\n");
	}		
}


int aux_b2(){
	try {
		throw B("");
	}
	catch(A x){ return 1; }
	catch(B x){ return 2; }
}

int test_b2(){
	if( aux_b2() == 2)
		printf("pass, test_b2\n");
	else
		printf("failed, test_b2\n");
}

int aux_b3(){
	try {
		throw A(2);
	}
	catch (A x){ return x+1; }
	finally{ return 0; }
}

int test_b3(){
	if( aux_b3() == 3)
		printf("pass, test_b3\n");
	else
		printf("failed, test_b3\n");
}


int aux_b6(){
	int x;
	x=0;
	try{
		throw Z(2);
	}
	finally{
		x++;
		if( x ==  1)
			printf("pass, test_b6 1\n");
	}
	printf("failed, test_b6 1\n");
  return x;
}

int test_b6(){
	try{
		aux_b6();
		printf("failed, test_b6 2\n");
	}catch( Z z){
		printf("pass, test_b6 2\n");
	}
}


int aux1_b7(int* p){
	try{
		p[0]++;
		return p;
	}finally{
		p[0]++;
	}
}

int aux2_b7(){
	int* x;
	x = malloc(8);
	x[0]=0;
	return (aux1_b7(x))[0];
}

int test_b7(){
	if( aux2_b7() == 2)
		printf("pass, test_b7\n");
	else
		printf("failed, test_b7\n");
}


int aux1_twisted1(){
	return 42;
}

int aux2_twisted1(){
	int x;
	try{
		x=aux1_twisted1();
		x++;
		return x;
	}finally{
		x++;
		printf("pass, test_twisted1 1, %d\n", x);
	}
}

int test_twisted1(){
	if( aux2_twisted1() == 43) 
		printf("pass, test_twisted1 2\n");
	else
		printf("failed, test_twisted1\n");
}

int launch_test(){
	printf("---------------------------------------------------------\n");
	printf("Tests set : 16 tests\n");
	printf("Expected succeed : 31\n");
	printf("---------------------------------------------------------\n\n\n");

	
	printf("Test : result_throw\n");
	printf("expected : 1\n");
	try{
		test_throw();
	}catch( E e){
		printf("pass, result_throw\n");
	}
	printf("---------------------------------------------------------\n");
	
	printf("Test : result_call\n");
	printf("expected : 1\n");
	try{
		test_call();
	}catch( E e){
		printf("pass, result_call\n");
	}
	printf("---------------------------------------------------------\n");

	
	printf("Test : test_try_no_excep_no_finally_no_return\n");
	printf("expected : 2\n");
	test_try_no_excep_no_finally_no_return();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_try_no_excep_no_finally_return\n");
	printf("expected : 1\n");
	test_try_no_excep_no_finally_return();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_try_no_excep_finally_no_return\n");
	printf("expected : 3\n");
	test_try_no_excep_finally_no_return();
	printf("---------------------------------------------------------\n");

	printf("Test : test_try_no_excep_finally_return\n");
	printf("expected : 3\n");
	test_try_no_excep_finally_return();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_try_no_excep_finally_return_2\n");
	printf("expected : 3\n");
	test_try_no_excep_finally_return_2();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_try_no_excep_finally_return_3\n");
	printf("expected : 3\n");
	test_try_no_excep_finally_return_3();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_try_excep_finally_return_no_handler\n");
	printf("expected : 2\n");
	test_try_excep_finally_return_no_handler();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_try_excep_finally_return_handler\n");
	printf("expected : 3\n");
	test_try_excep_finally_return_handler();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_try_excep_in_catch\n");
	printf("expected : 2\n");
	test_try_excep_in_catch();
	printf("---------------------------------------------------------\n");
	
	
	printf("Test : test_b2\n");
	printf("expected : 1\n");
	test_b2();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_b3\n");
	printf("expected : 1\n");
	test_b3();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_b6\n");
	printf("expected : 2\n");
	test_b6();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_b7\n");
	printf("expected : 1\n");
	test_b7();
	printf("---------------------------------------------------------\n");
	
	printf("Test : test_twisted1\n");
	printf("expected : 2\n");
	test_twisted1();
	printf("---------------------------------------------------------\n");
}

int main(){
	launch_test();
}

