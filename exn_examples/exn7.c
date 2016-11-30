int* f(int* p) {
  try {
    p[0]++;
    return p;
  } finally {
    p[0]++;
  }
}
int main() {
  int* x;
  x = malloc(8);
  x[0]=0;
  return (f(x))[0];
}
