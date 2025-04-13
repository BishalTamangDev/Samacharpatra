import 'package:flutter/cupertino.dart';
import 'package:samacharpatra/core/data/source/local/local_service.dart';
import 'package:samacharpatra/features/settings/business/repositories/setting_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingRepositoryImpl implements SettingRepository {
  // fetch api key
  @override
  Future<String> fetchApiKey() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('api_key') ?? '';
    } catch (e, stackTrace) {
      debugPrint("Setting -> Error fetching api key :: $e\n$stackTrace");
      return '';
    }
  }

  // delete saved articles
  @override
  Future<bool> deleteSavedArticles() async {
    return await LocalService.getInstance().deleteAll();
  }
}
