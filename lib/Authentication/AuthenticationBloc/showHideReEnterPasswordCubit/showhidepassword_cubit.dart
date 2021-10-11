import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'showhidepassword_state.dart';

class ShowHideReEnterPasswordCubit extends Cubit<ShowHideReEnterPasswordState> {
  bool showHideReEnterPasswordBool = false;
  ShowHideReEnterPasswordCubit()
      : super(ShowHideReEnterPasswordState(showHideReEnterPassWord: true));

  updateShowHidePasswordBool(bool val) {
    showHideReEnterPasswordBool = val;
    emit(state.copyWith(boolean: showHideReEnterPasswordBool));
  }
}
