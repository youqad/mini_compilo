int main() {
  try {
    throw A(2);
  }
  catch (A x) { return x+1; }
  finally { print("0"); }
}
