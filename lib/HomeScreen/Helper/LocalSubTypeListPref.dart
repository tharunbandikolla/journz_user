import 'package:shared_preferences/shared_preferences.dart';

class LocalArticleCAtegorySharedPreferences {
  static const String _FavCategoryKey = "LOCALSUBTYPELIST";

  setLocalCategories(List<String> locCategory, SharedPreferences pref) {
    pref.setStringList(_FavCategoryKey, locCategory);
  }

  Future<List<String>?> getLocalCategories(SharedPreferences pref) async {
    List<String>? favData = await pref.getStringList(_FavCategoryKey);
    return favData;
  }
}
