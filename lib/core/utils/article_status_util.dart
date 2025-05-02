// toggle article status
import '../business/entities/article_entity.dart';
import '../constants/article_status_enum.dart';
import '../data/source/local/local_service.dart';

Future<ArticleStatusEnum> toggleArticleStatus({required String task, required ArticleEntity article}) async {
  // task :: save & delete
  // alreadySaved :: true || false

  // check if the article is already present
  ArticleStatusEnum response = ArticleStatusEnum.unknown;

  // check if the article is already saved
  bool alreadySaved = await LocalService.getInstance().isSaved(article.url!);

  if (task == 'save') {
    if (alreadySaved) {
      response = ArticleStatusEnum.alreadySaved;
    } else {
      bool saved = await LocalService.getInstance().save(article);
      response = saved ? ArticleStatusEnum.saved : ArticleStatusEnum.error;
    }
  } else {
    // task :: delete
    if (!alreadySaved) {
      response = ArticleStatusEnum.alreadyDeleted;
    } else {
      bool deleted = await LocalService.getInstance().delete(article);
      response = deleted ? ArticleStatusEnum.deleted : ArticleStatusEnum.error;
    }
  }
  return response;
}
