class AppFunctions {
  // get word-case
  static String getSentenceCase(String word) {
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }
}
