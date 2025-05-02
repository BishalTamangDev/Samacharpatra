import 'package:samacharpatra/core/data/source/local/local_service.dart';
import 'package:samacharpatra/features/article/business/repositories/article_repository.dart';

import '../../../../core/business/entities/article_entity.dart';
import '../../../../core/constants/article_status_enum.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  // toggle article status
  @override
  Future<ArticleStatusEnum> toggleArticleStatus({required String task, required ArticleEntity article}) async {
    // task -> save || delete
    // check current status
    final bool isSaved = await LocalService.getInstance().isSaved(article.url ?? '-');

    // update status
    if (task == 'save') {
      if (isSaved) {
        return ArticleStatusEnum.alreadySaved;
      } else {
        final bool response = await LocalService.getInstance().save(article);
        return response ? ArticleStatusEnum.saved : ArticleStatusEnum.error;
      }
    } else if (task == 'delete') {
      if (!isSaved) {
        return ArticleStatusEnum.alreadyDeleted;
      } else {
        final bool response = await LocalService.getInstance().delete(article);
        return response ? ArticleStatusEnum.deleted : ArticleStatusEnum.error;
      }
    } else {
      return ArticleStatusEnum.error;
    }
  }
}
