import 'dart:convert';
import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import '/Common/AppTheme/AppTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //static  SharedPreferences preferences;
  static const String KEY_SELECTED_THEME = "key_selected_theme";

  static init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
  }

  static void saveTheme(
      AppTheme? selectedTheme, SharedPreferences preferences) {
    if (null == selectedTheme) {
      selectedTheme = AppTheme.darkTheme;
    }
    String theme = jsonEncode(selectedTheme.toString());
    print('nnn encoded theme $theme');
    preferences.setString(
        KEY_SELECTED_THEME, jsonEncode(selectedTheme.toString()));
  }

  static AppTheme? getTheme(
      SharedPreferences preferences, ThemebasedwidgetCubit cubit) {
    print('nnn enter getTheme');
    String? theme = preferences.getString(KEY_SELECTED_THEME);
    print('nnn theme value $theme');
    if (theme == null) {
      print('nnn theme null');
      cubit.getThemeVal(false);
      return AppTheme.darkTheme;
    }
    return getThemeFromString(jsonDecode(theme), cubit);
  }

  static AppTheme getThemeFromString(
      String themeString, ThemebasedwidgetCubit cubit) {
    for (AppTheme theme in AppTheme.values) {
      if (theme.toString() == themeString) {
        print('nnn navitheme ${theme.toString()}    and  $themeString');
        if (theme == AppTheme.darkTheme) {
          cubit.getThemeVal(false);
        }
        if (theme == AppTheme.lightTheme) {
          cubit.getThemeVal(true);
        }
        return theme;
      }
    }
    cubit.getThemeVal(false);
    return AppTheme.darkTheme;
  }
}
