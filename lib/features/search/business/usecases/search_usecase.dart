import 'package:dartz/dartz.dart';
import 'package:samacharpatra/features/search/data/repositories/search_repository_impl.dart';

import '../../../../core/business/entities/article_entity.dart';
import '../../../../core/errors/failures/failure.dart';

class SearchUseCase {
  final SearchRepositoryImpl searchRepository;

  SearchUseCase({required this.searchRepository});

  Future<Either<Failure, List<ArticleEntity>>> call({required String searchTitle}) async {
    return await searchRepository.search(searchTitle: searchTitle);
  }
}
