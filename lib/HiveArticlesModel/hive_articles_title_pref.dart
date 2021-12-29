import 'package:shared_preferences/shared_preferences.dart';

class HiveArticlesTitlePreferences {
  static String articleTitleKey = "Article_Title_Key";

  setArticleTitles(SharedPreferences pref, List<dynamic>? data) {
    if (data != null) {
      List<String> titles = List.from(data);
      pref.setStringList(articleTitleKey, titles);
    } else {
      pref.setStringList(articleTitleKey, []);
    }
  }

  Future<List<String>?> getArticleTitle(SharedPreferences pref) async {
    List<String>? data = [];
    data = await pref.getStringList(articleTitleKey);
    return data;
  }
}
