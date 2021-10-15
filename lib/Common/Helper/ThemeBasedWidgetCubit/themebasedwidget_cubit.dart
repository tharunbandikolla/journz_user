import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'themebasedwidget_state.dart';

class ThemebasedwidgetCubit extends Cubit<ThemebasedwidgetState> {
  ThemebasedwidgetCubit() : super(ThemebasedwidgetState(isLightTheme: false));

  getThemeVal(bool val) {
    emit(state.copyWith(themeVal: val));
  }
}
