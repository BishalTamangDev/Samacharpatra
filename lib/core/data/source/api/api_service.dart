import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:samacharpatra/core/data/source/fake/fake_service.dart';
import 'package:samacharpatra/features/article/business/entities/article_entity.dart';
import 'package:samacharpatra/features/article/data/models/article_model.dart';

import '../../../errors/failures/failure.dart';

class ApiService {
  final client = http.Client();

  // pageSize
  int page = 1;
  final int pageSize = 7;
  int searchPageSize = 10;

  final useFakeSource = true;

  // fetch all article
  Future<Either<Failure, List<ArticleEntity>>> fetch({int newPage = 1}) async {
    if (useFakeSource) {
      return await FakeService().fetch();
    }
    try {
      // api key
      final String? apiKey = dotenv.env['API_KEY'];

      if (apiKey == null) {
        throw Exception("Api key not found!");
      }

      // base uwl
      final String baseUrl =
          "https://newsapi.org/v2/top-headlines?country=us&pageSize=$pageSize&page=$newPage&apiKey=$apiKey";

      // final url
      final url = Uri.parse(baseUrl + apiKey);

      // response
      final response = await client.get(url);

      debugPrint("Response status code :: ${response.statusCode}");
      debugPrint("Response body :: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        final List<Map<String, dynamic>> articles = jsonData['articles'];

        for (var article in articles) {
          final ArticleModel articleModel = ArticleModel.fromJson(article);
          debugPrint(articleModel.toString());
        }

        return Right([]);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching articles :: $e\n$stackTrace");
      return Left(ServerFailure(message: "WIP"));
    }
  }

  // search article
  Future<Either<Failure, List<ArticleEntity>>> search() async {
    return Left(ServerFailure(message: 'WIP'));
  }
}
