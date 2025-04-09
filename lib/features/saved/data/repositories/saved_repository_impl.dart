import 'package:dartz/dartz.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/data/source/local/local_service.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';
import 'package:samacharpatra/features/saved/business/repositories/saved_repository.dart';

class SavedRepositoryImpl implements SavedRepository {
  // fetch all articles
  @override
  Future<Either<Failure, List<ArticleEntity>>> fetchAllArticles() async {
    return await LocalService.getInstance().fetchArticles();
  }
}
