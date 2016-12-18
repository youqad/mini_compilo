int main() {
  try {
    throw B("");
  }
  catch (A x) { printf("%d",1); }
  catch (B x) { printf("%d",2); }
  return;
}
