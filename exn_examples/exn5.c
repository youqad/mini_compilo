int main() {
  try {
    throw Z(2);
  }
  finally {
    return 0;
  }
}
