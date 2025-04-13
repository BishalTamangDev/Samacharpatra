import 'package:intl/intl.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/constants/app_constants.dart';

import '../data/source/local/local_service.dart';

class AppFunctions {
  // get word-case
  static String getSentenceCase(String word) {
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  // toggle article status
  static Future<ArticleStatusEnum> toggleArticleStatus({required String task, required ArticleEntity article}) async {
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

  // get formatted local time
  static String getFormattedLocalDateTime(String initial) {
    final DateTime dateTime = DateTime.parse(initial);
    final DateTime localDateTime = dateTime.toLocal();
    final String formattedDateTime = DateFormat('dd MMMM, yyyy, hh:mm a').format(localDateTime);
    return formattedDateTime;
  }
}
