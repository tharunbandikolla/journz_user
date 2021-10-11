import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/Common/AppTheme/AppTheme.dart';
import 'package:flutter/material.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
            ThemeState(themeData: AppThemes.appThemeData[AppTheme.darkTheme]));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeEvent) {
      yield ThemeState(themeData: AppThemes.appThemeData[event.appTheme]);
    }
  }
}

/*
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  // at this point you should be already have a mainSharedPreferences already initialized, could be in SplashScreen
  // to prevent async calls in the initialState

  @override
  ThemeState get initialState => ThemeState(
      themeData: appThemeData[
          MyApp.mainSharedPreferences.getInt("selectedThemeIndex") ??
              AppTheme.GreenLight]);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      await _persistTheme(event.theme);
      yield ThemeState(themeData: appThemeData[event.theme]);
    }
  }

  _persistTheme(AppTheme theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("selectedThemeIndex", theme.index);
    // or you could save the theme.toString()
    // prefs.setString("selectedTheme", theme.toString());
  }
} */
