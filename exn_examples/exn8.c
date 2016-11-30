int main() {
  try {
    throw A(1);
  }
  catch (A x) { return 1; }
  finally { return 2; }
}
