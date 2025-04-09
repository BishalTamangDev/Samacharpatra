import 'package:dartz/dartz.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/data/source/api/api_service.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';
import 'package:samacharpatra/features/home/business/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, List<ArticleEntity>>> fetchArticles() async {
    return await ApiService().fetchArticles();
  }
}
