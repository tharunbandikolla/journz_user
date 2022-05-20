import 'package:shared_preferences/shared_preferences.dart';

class HiveArticlesTitlePreferences {
  static String articleTitleKey = "Article_Title_Key";

  storeArticleName(SharedPreferences pref, List<dynamic>? val) {
    if (val != null) {
      List<String> data = List.from(val);
      pref.setStringList(articleTitleKey, data);
    } else {
      pref.setStringList(articleTitleKey, []);
    }
  }

  Future<List<String>?> retriveArticleName(SharedPreferences pref) async {
    List<String>? data = [];
    data = await pref.getStringList(articleTitleKey);
    return data;
  }
}
