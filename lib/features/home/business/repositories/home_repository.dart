import 'package:dartz/dartz.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';

import '../../../../core/errors/failures/failure.dart';

abstract class HomeRepository {
  // fetch articles
  Future<Either<Failure, List<ArticleEntity>>> fetchArticles();
}
