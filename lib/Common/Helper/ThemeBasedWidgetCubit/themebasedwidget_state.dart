part of 'themebasedwidget_cubit.dart';

class ThemebasedwidgetState {
  bool isLightTheme = false;
  ThemebasedwidgetState({required this.isLightTheme});

  ThemebasedwidgetState copyWith({required bool themeVal}) {
    return ThemebasedwidgetState(isLightTheme: themeVal);
  }
}
