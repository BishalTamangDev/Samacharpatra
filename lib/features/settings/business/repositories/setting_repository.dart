abstract class SettingRepository {
  // fetch api key
  Future<String> fetchApiKey();

  // delete saved articles
  Future<bool> deleteSavedArticles();
}
