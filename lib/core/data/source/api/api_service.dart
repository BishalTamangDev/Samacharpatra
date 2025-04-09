import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/data/models/article_model.dart';
import 'package:samacharpatra/core/data/source/fake/fake_service.dart';
import 'package:samacharpatra/core/data/source/local/local_service.dart';
import 'package:samacharpatra/core/errors/exception/http_exception_handler.dart';

import '../../../errors/failures/failures.dart';

class ApiService {
  final client = http.Client();

  // pageSize
  int page = 1;
  final int pageSize = 7;
  int searchPageSize = 10;

  final useFakeSource = false;

  // fetch all article
  Future<Either<Failure, List<ArticleEntity>>> fetchArticles({int newPage = 1}) async {
    if (useFakeSource) {
      return await FakeService().fetch();
    }
    try {
      // api key
      final String? apiKey = dotenv.env['API_KEY'];

      if (apiKey == null) {
        return Left(ApiKeyNotSetFailure());
      }

      Map<String, String> headers = {'Authorization': "Bearer $apiKey", 'Content-Type': 'application/json'};

      // base uwl
      final String baseUrl = "https://newsapi.org/v2/top-headlines?country=us&pageSize=$pageSize&page=$newPage";

      // final url
      final Uri url = Uri.parse(baseUrl);

      // response
      final response = await client.get(url, headers: headers).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        final List<dynamic> data = jsonData['articles'];

        // map data into entity list
        List<ArticleEntity> articles = data.map((datum) => ArticleModel.fromJson(datum).toEntity()).toList();

        // fetch offline article
        final localResponse = await LocalService.getInstance().fetchArticles();

        List<String> urlList = [];

        localResponse.fold((failure) {}, (localArticles) {
          for (var article in localArticles) {
            urlList.add(article.url!);
          }
        });

        List<ArticleEntity> finalArticles = [];

        for (var article in articles) {
          article.saved = urlList.contains(article.url) ? true : false;
          finalArticles.add(article);
        }

        return Right(finalArticles);
      } else {
        return Left(handleHttpException(response.statusCode));
      }
    } on http.ClientException catch (_) {
      return Left(NetworkFailure("Connection error. Please try again later."));
    } on TimeoutException catch (_) {
      return Left(NetworkFailure("Server took too long to respond."));
    } on SocketException catch (_) {
      return Left(NetworkFailure("Unable to connect. Check your network settings."));
    } catch (e, stackTrace) {
      debugPrint("Error fetching article :: $e\n$stackTrace");
      return Left(UnknownFailure());
    }
  }

  // search article
  Future<Either<Failure, List<ArticleEntity>>> search(String searchTitle) async {
    if (useFakeSource) {
      return await FakeService().search(searchTitle);
    }
    try {
      // api key
      final String? apiKey = dotenv.env['API_KEY'];

      if (apiKey == null) {
        return Left(ApiKeyNotSetFailure());
      }

      Map<String, String> headers = {'Authorization': "Bearer $apiKey", 'Content-Type': 'application/json'};

      // base uwl
      final String baseUrl = "https://newsapi.org/v2/everything?q=$searchTitle&sortBy=popularity&page=$page&pageSize=10";

      // final url
      final Uri url = Uri.parse(baseUrl);

      // response
      final response = await client.get(url, headers: headers).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        final List<dynamic> data = jsonData['articles'];

        // map data into entity list
        List<ArticleEntity> articles = data.map((datum) => ArticleModel.fromJson(datum).toEntity()).toList();

        // fetch offline article
        final localResponse = await LocalService.getInstance().fetchArticles();

        List<String> urlList = [];

        localResponse.fold((failure) {}, (localArticles) {
          for (var article in localArticles) {
            urlList.add(article.url!);
          }
        });

        List<ArticleEntity> finalArticles = [];

        for (var article in articles) {
          article.saved = urlList.contains(article.url) ? true : false;
          finalArticles.add(article);
        }

        return Right(finalArticles);
      } else {
        return Left(handleHttpException(response.statusCode));
      }
    } on http.ClientException catch (_) {
      return Left(NetworkFailure("Connection error. Please try again later."));
    } on TimeoutException catch (_) {
      return Left(NetworkFailure("Server took too long to respond."));
    } on SocketException catch (_) {
      return Left(NetworkFailure("Unable to connect. Check your network settings."));
    } catch (e, stackTrace) {
      debugPrint("Error fetching article :: $e\n$stackTrace");
      return Left(UnknownFailure());
    }
  }
}
