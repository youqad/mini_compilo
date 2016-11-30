int main() {
  int x;
  x=0;
  try {
    throw Z(2);
  }
  finally {
    x++;
  }
  return x;
}
