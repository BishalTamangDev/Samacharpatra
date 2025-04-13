import 'package:samacharpatra/core/constants/app_constants.dart';

import '../../../../core/business/entities/article_entity.dart';

abstract class ArticleRepository {
  // toggle article status
  Future<ArticleStatusEnum> toggleArticleStatus({required String task, required ArticleEntity article});
}
