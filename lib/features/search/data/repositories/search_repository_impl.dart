import 'package:dartz/dartz.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/data/source/api/api_service.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';
import 'package:samacharpatra/features/search/business/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<Either<Failure, List<ArticleEntity>>> search({required String searchTitle}) async {
    return await ApiService().search(searchTitle);
  }
}
