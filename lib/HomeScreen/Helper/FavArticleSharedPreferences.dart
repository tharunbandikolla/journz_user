import 'package:shared_preferences/shared_preferences.dart';

class FavArticleSharedPreferences {
  static const String _FavCategoryKey = "FAVOURITECATEGORYKEY";

  setFavCategories(List<String> favCategory, SharedPreferences pref) {
    pref.setStringList(_FavCategoryKey, favCategory);
  }

  getFavCategories(SharedPreferences pref) async {
    List<String>? favData = await pref.getStringList(_FavCategoryKey);
    return favData;
  }
}
