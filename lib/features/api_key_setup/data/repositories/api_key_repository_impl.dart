import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';
import 'package:samacharpatra/features/api_key_setup/business/repositories/api_key_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyRepositoryImpl extends ApiKeyRepository {
  // fetch api key
  @override
  Future<Either<Failure, String>> fetchApiKey() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String apiKey = prefs.getString('api_key') ?? '';
      return Right(apiKey);
    } catch (e, stackTrace) {
      debugPrint("Error fetching api key :: $e\n$stackTrace");
      return Left(SharedPreferencesFailure());
    }
  }

  // set api key
  @override
  Future<bool> setApiKey(String apiKey) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool response = await prefs.setString('api_key', apiKey);
      return response;
    } catch (e, stackTrace) {
      debugPrint("Error setting api key :: $e\n$stackTrace");
      return false;
    }
  }

  // delete api key
  @override
  Future<bool> deleteApiKey() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool response = await prefs.remove('api_key');
      return response;
    } catch (e, stackTrace) {
      debugPrint("Error deleting api key :: $e\n$stackTrace");
      return false;
    }
  }
}
