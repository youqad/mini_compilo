int main() {
    int *tab;
    int resu;
    int a, b;
    tab = malloc(3*8);
    tab[0] = 1;
    tab[1] = 2;
    tab[2] = 3;


    tab[printf("2"), 0] = (printf("3"), 0);
    tab[tab[0]++]++;

    printf("%d", (a=b=3));
    return 0;
}
