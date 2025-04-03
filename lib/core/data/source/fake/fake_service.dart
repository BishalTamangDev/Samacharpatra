import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:samacharpatra/features/article/business/entities/article_entity.dart';
import 'package:samacharpatra/features/article/data/models/article_model.dart';

import '../../../errors/failures/failure.dart';

class FakeService {
  // fetch articles
  Future<Either<Failure, List<ArticleEntity>>> fetch() async {
    try {
      List<ArticleEntity> data = [];

      // load json file as string
      final String fileString = await rootBundle.loadString('assets/files/articles.json');

      // convert to json format
      var jsonData = jsonDecode(fileString);

      debugPrint("FAKE SOURCE DATA :: $jsonData");

      List<Map<String, dynamic>> articles = jsonData['articles'];

      for (var article in articles) {
        final ArticleModel articleModel = ArticleModel.fromJson(article);
        debugPrint(articleModel.toString());
      }

      return Right(data);
    } catch (e, stackTrace) {
      debugPrint("Error fetching articles :: $e\n$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // search articles
  Future<Either<Failure, List<ArticleEntity>>> search(String title) async {
    try {
      List<ArticleEntity> articles = [];

      // load json file as string
      final String fileString = await rootBundle.loadString('assets/files/articles.json');

      // convert to json format
      var jsonData = jsonDecode(fileString);

      debugPrint("FAKE SOURCE DATA :: $jsonData");

      return Right(articles);
    } catch (e, stackTrace) {
      debugPrint("Error fetching articles :: $e\n$stackTrace");
      return Left(ServerFailure(message: 'WIP'));
    }
  }
}
