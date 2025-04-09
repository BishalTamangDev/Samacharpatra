import 'package:dartz/dartz.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';
import 'package:samacharpatra/features/home/data/repositories/home_repository_impl.dart';

class FetchArticlesUseCase {
  final HomeRepositoryImpl homeRepository;

  FetchArticlesUseCase(this.homeRepository);

  Future<Either<Failure, List<ArticleEntity>>> call() async {
    return await homeRepository.fetchArticles();
  }
}
