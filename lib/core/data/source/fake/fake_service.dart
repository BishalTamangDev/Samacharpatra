import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/data/models/article_model.dart';

import '../../../errors/failures/failures.dart';
import '../local/local_service.dart';

class FakeService {
  // fetch articles
  Future<Either<Failure, List<ArticleEntity>>> fetch() async {
    try {
      // load json file as string
      final String fileString = await rootBundle.loadString('assets/files/articles.json');

      // convert to json format
      final Map<String, dynamic> jsonData = jsonDecode(fileString);

      // get articles as json
      final List<dynamic> data = jsonData['articles'];

      // map data into entity list
      final List<ArticleEntity> articles = data.map((datum) => ArticleModel.fromJson(datum).toEntity()).toList();

      // fetch offline article
      final localResponse = await LocalService.getInstance().fetchArticles();

      // url list
      List<String> urlList = [];

      localResponse.fold(
        (failure) {
          debugPrint("Local data failure :: $failure");
        },
        (localArticles) {
          for (var article in localArticles) {
            urlList.add(article.url!);
          }
        },
      );

      List<ArticleEntity> finalArticles = [];

      for (var article in articles) {
        article.saved = urlList.contains(article.url) ? true : false;
        finalArticles.add(article);
      }

      return Right(finalArticles);
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
      final Map<String, dynamic> jsonData = jsonDecode(fileString);

      // get articles as json
      final List<dynamic> data = jsonData['articles'];

      // map data into entity list
      final List<ArticleEntity> articles = data.map((datum) => ArticleModel.fromJson(datum).toEntity()).toList();

      // fetch offline article
      final localResponse = await LocalService.getInstance().fetchArticles();

      // url list
      List<String> urlList = [];

      localResponse.fold(
        (failure) {
          debugPrint("Local data failure :: $failure");
        },
        (localArticles) {
          for (var article in localArticles) {
            urlList.add(article.url!);
          }
        },
      );

      List<ArticleEntity> finalArticles = [];

      for (var article in articles) {
        article.saved = urlList.contains(article.url) ? true : false;
        finalArticles.add(article);
      }

      return Right(finalArticles);
    } catch (e, stackTrace) {
      debugPrint("Error searching articles :: $e\n$stackTrace");
      return Left(UnknownFailure());
    }
  }
}
