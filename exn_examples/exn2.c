int main() {
  try {
    throw B("");
  }
  catch (A x) { return 1; }
  catch (B x) { return 2; }
}
