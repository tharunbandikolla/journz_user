import 'package:bloc/bloc.dart';

part 'startupthemehelper_state.dart';

class StartupthemehelperCubit extends Cubit<StartupthemehelperState> {
  StartupthemehelperCubit()
      : super(StartupthemehelperState(iconSizeChanger: false));

  isDarkTheme(bool v) {
    //Future.delayed(Duration(seconds: 1), () {
    emit(state.copyWith(val: v));
    // });
  }
}
