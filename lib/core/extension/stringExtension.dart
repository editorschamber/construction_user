extension StringExtension on String {
  String duplicate() {
    return this + " " + this;
  }

  bool isNull() {
    return this.isEmpty;
  }
}
