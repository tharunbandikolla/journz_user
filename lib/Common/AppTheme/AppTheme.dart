import 'package:google_fonts/google_fonts.dart';

import '/Common/AppTheme/Colour.dart';
import 'package:flutter/material.dart';

enum AppTheme { lightTheme, darkTheme }

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
        primarySwatch: AppColour.black,
        brightness: Brightness.light,
        accentColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.black, unselectedItemColor: Colors.grey)),
    AppTheme.darkTheme: ThemeData(
        
        brightness: Brightness.dark,
        primarySwatch: AppColour.white,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.white, unselectedItemColor: Colors.grey)),
  };
}
