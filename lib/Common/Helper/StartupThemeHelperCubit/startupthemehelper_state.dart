part of 'startupthemehelper_cubit.dart';

class StartupthemehelperState {
  bool? iconSizeChanger;
  StartupthemehelperState({this.iconSizeChanger});

  StartupthemehelperState copyWith({bool? val}) {
    return StartupthemehelperState(
        iconSizeChanger: val ?? this.iconSizeChanger);
  }
}
