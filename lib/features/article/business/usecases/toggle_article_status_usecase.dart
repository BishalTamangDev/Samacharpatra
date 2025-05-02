import 'package:samacharpatra/features/article/data/repository/article_repository.dart';

import '../../../../core/business/entities/article_entity.dart';
import '../../../../core/constants/article_status_enum.dart';

class ToggleArticleStatusUseCase {
  final ArticleRepositoryImpl articleRepository;

  ToggleArticleStatusUseCase(this.articleRepository);

  Future<ArticleStatusEnum> call({required String task, required ArticleEntity article}) async {
    return await articleRepository.toggleArticleStatus(task: task, article: article);
  }
}
