import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/data/models/article_model.dart';
import 'package:samacharpatra/core/data/source/fake/fake_service.dart';

import '../../../errors/failures/failure.dart';

class ApiService {
  final client = http.Client();

  // pageSize
  int page = 1;
  final int pageSize = 7;
  int searchPageSize = 10;

  final useFakeSource = true;

  // fetch all article
  Future<Either<Failure, List<ArticleEntity>>> fetchArticles({int newPage = 1}) async {
    if (useFakeSource) {
      return await FakeService().fetch();
    }
    try {
      // api key
      final String? apiKey = dotenv.env['API_KEY'];

      if (apiKey == null) {
        throw Exception("Api key not found!");
      }

      Map<String, String> headers = {'Authorization': "Bearer $apiKey", 'Content-Type': 'application/json'};

      // base uwl
      final String baseUrl = "https://newsapi.org/v2/top-headlines?country=us&pageSize=$pageSize&page=$newPage";

      // final url
      final url = Uri.parse(baseUrl);

      // response
      final response = await client.get(url, headers: headers);

      debugPrint("Response status code :: ${response.statusCode}");
      debugPrint("Response body :: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        final List<dynamic> data = jsonData['articles'];

        List<ArticleEntity> articles = [];

        for (var datum in data) {
          final ArticleEntity entity = ArticleModel.fromJson(datum).toEntity();
          articles.add(entity);
        }

        return Right(articles);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching articles :: $e\n$stackTrace");
      return Left(ServerFailure(message: "WIP"));
    }
  }

  // search article
  Future<Either<Failure, List<ArticleEntity>>> search({required String searchTitle}) async {
    await Future.delayed(const Duration(seconds: 3));

    return Left(ServerFailure(message: 'WIP'));
  }
}
