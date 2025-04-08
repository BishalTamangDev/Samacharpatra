import 'package:dartz/dartz.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/errors/failures/failure.dart';
import 'package:samacharpatra/features/saved/data/repositories/saved_repository_impl.dart';

class FetchAllArticlesUseCase {
  final SavedRepositoryImpl savedRepository;

  FetchAllArticlesUseCase({required this.savedRepository});

  Future<Either<Failure, List<ArticleEntity>>> call() async {
    return savedRepository.fetchAllArticles();
  }
}
