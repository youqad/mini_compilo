// Some tests for C--
// Written by Laurent Prosperi, ENS Cachan, in 2015.

#ifndef MCC
#include <stdio.h>
#include <stdlib.h>
#endif

# define EOF (-1)

int fact (int n){
	int res;

	res = 1;
	while (n!=0){
		res = res * n;
		n--;
    }
	return res;
}

int test_cat(){
	int i, c;
	char** files;

	files = malloc( 2*8 );
	files[0] = "unitest.c";
	files[1] = "unitest2.c";

	for(i=0; i<2; i++){
		char *f;

		f = fopen (files[i], "r");
		while ((c = fgetc (f))!=EOF)
			fputc (c, stdout);
		fclose (f);
	}
	fflush (stdout);
}

int test_ordre(){
	int i, j;

	j = (i=3) + (i=4);
	printf ("Valeur de j=%d (normalement 7), valeur de i=%d.\n", j, i);
	fflush (stdout);
}

int test_fact(){
    int n, res;
	char* c;
	c="15";
    n = atoi(c); /* conversion chaine -> entier. */

    if (n<0){
		fprintf (stderr, "Ah non, quand meme, un nombre positif ou nul, s'il-vous-plait...\n");
		fflush (stderr);
		return 10;
	}

    res = fact (n);
    printf("fact  %s\n", (res == 1307674368000) ? "pass" : "failed");
	printf("fact  th=%d, value=%d\n",  1307674368000, res);
	printf("----------------------\n");
}

int test_n_dim(){
	int *tab;
	int *t;
	int i,j;

	tab = malloc( 8*100);
	for( i=0; i<100 ; i++){
		tab[i] = malloc( 8*10);
		for( j=0; j<10; j++){
			t 		= tab[i];
			t[j] 	= j*2 + i;
		}
	}

	for( i=0; i<100 ; i++)
		for( j=0; j<10; j++){
			printf("tab[%d][%d]  %s\n", i, j, (2*j+i == tab[i][j]) ? "pass" : "failed");
			printf("tab[%d][%d]  th=%d, value=%d\n", i, j, 2*j+i, tab[i][j]);
			printf("----------------------\n");
		}

	for( i=0; i<100 ; i++)
		free( tab[i] );

	free( tab );
}

int test_ret(int n){
	if( n > 10 && n < 21)
		return 151;
	if( n >20)
		return 51;
	return 42;
}

int id_1(int i){
	return i+1;
}

int main(int argc, int** argv){
	//test_cat();
	test_ordre();
	test_fact();
	test_n_dim();

	printf("fact  %s\n", (test_ret(11) == 151) ? "pass" : "failed");
	printf("fact  th=%d, value=%d\n",  151, test_ret(11));
	printf("----------------------\n");

	printf("fact  %s\n", (test_ret(21) == 51) ? "pass" : "failed");
	printf("fact  th=%d, value=%d\n",  51, test_ret(21));
	printf("----------------------\n");

	printf("fact  %s\n", (test_ret(2) == 42) ? "pass" : "failed");
	printf("fact  th=%d, value=%d\n",  42, test_ret(2));
	printf("----------------------\n");

	printf("id_1  %s\n", id_1(id_1(1)) == 3 ? "pass" : "failed");
	printf("id_1  th=%d, value=%d\n", 3 , id_1(id_1(1)));
	printf("----------------------\n");
	return;
}
