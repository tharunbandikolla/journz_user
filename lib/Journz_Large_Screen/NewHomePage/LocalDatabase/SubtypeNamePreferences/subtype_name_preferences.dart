import 'package:shared_preferences/shared_preferences.dart';

class SubtypeNamePreferences {
  static String subtypePrefKey = 'SubtypeNamePrefKey1';

  storeSubtypeName(SharedPreferences pref, List<dynamic>? val) {
    if (val != null) {
      List<String> data = List.from(val);
      pref.setStringList(subtypePrefKey, data);
    } else {
      pref.setStringList(subtypePrefKey, []);
    }
  }

  Future<List<String>?> retriveSubtypeName(SharedPreferences pref) async {
    List<String>? data = [];
    data = await pref.getStringList(subtypePrefKey);
    return data;
  }
}
