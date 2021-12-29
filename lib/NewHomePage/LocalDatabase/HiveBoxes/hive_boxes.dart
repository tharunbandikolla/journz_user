import 'package:hive/hive.dart';
import 'package:journz_web/Articles/Comments/hive_articles_comments.dart';

import 'package:journz_web/HiveArticlesModel/ArticleModel/hive_article_data.dart';

import 'package:journz_web/NewHomePage/LocalDatabase/HiveArticleSubtypeModel/hive_article_subtype_model.dart';

class Boxes {
  static Box<HiveArticlesSubtypes> getArticleSubtypeFromCloud() =>
      Hive.box<HiveArticlesSubtypes>('HiveArticlesSubtype01');

  static Box<HiveArticleData> getArticleFromCloud() =>
      Hive.box<HiveArticleData>('HiveArticlesData01');

  static Box<HiveArticlesComments> getArticleCommentsFromCloud() =>
      Hive.box<HiveArticlesComments>('HiveArticlesComments01');
}
