import 'package:hive/hive.dart';
import '/Journz_Large_Screen/Articles/Comments/hive_articles_comments.dart';

import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';

import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveArticleSubtypeModel/hive_article_subtype_model.dart';

class Boxes {
  static Box<HiveArticlesSubtypes> getArticleSubtypeFromCloud() =>
      Hive.box<HiveArticlesSubtypes>('HiveArticlesSubtype01');

  static Box<HiveArticleData> getArticleFromCloud() =>
      Hive.box<HiveArticleData>('HiveArticlesData01');

  static Box<HiveArticlesComments> getArticleCommentsFromCloud() =>
      Hive.box<HiveArticlesComments>('HiveArticlesComments01');
}
