import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/data/models/article_model.dart';

import '../../../errors/failures/failures.dart';

class FakeService {
  // fetch articles
  Future<Either<Failure, List<ArticleEntity>>> fetch() async {
    try {
      // load json file as string
      final String fileString = await rootBundle.loadString('assets/files/articles.json');

      // convert to json format
      final jsonData = jsonDecode(fileString);

      final List<dynamic> data = jsonData['articles'];

      final List<ArticleEntity> articles = data.map((datum) => ArticleModel.fromJson(datum).toEntity()).toList();

      return Right(articles);
    } catch (e, stackTrace) {
      debugPrint("Error fetching articles :: $e\n$stackTrace");
      return Left(UnknownFailure());
    }
  }

  // search articles
  Future<Either<Failure, List<ArticleEntity>>> search(String title) async {
    try {
      // load json file as string
      final String fileString = await rootBundle.loadString('assets/files/articles.json');

      // convert to json format
      final jsonData = jsonDecode(fileString);

      final List<dynamic> data = jsonData['articles'];

      final List<ArticleEntity> articles = data.map((datum) => ArticleModel.fromJson(datum).toEntity()).toList();

      return Right(articles);
    } catch (e, stackTrace) {
      debugPrint("Error fetching articles :: $e\n$stackTrace");
      return Left(UnknownFailure());
    }
  }
}
