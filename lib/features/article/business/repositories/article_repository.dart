import '../../../../core/business/entities/article_entity.dart';
import '../../../../core/constants/article_status_enum.dart';

abstract class ArticleRepository {
  // toggle article status
  Future<ArticleStatusEnum> toggleArticleStatus({required String task, required ArticleEntity article});
}
