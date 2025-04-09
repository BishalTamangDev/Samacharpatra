import 'package:dartz/dartz.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';

abstract class SavedRepository {
  // fetch articles
  Future<Either<Failure, List<ArticleEntity>>> fetchAllArticles();
}
