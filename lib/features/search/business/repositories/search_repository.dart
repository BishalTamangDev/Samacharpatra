import 'package:dartz/dartz.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<ArticleEntity>>> search({required String searchTitle});
}
