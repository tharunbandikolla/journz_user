import 'package:bloc/bloc.dart';

part 'show_hide_signup_reenter_password_state.dart';

class ShowHideSignupReenterPasswordCubit
    extends Cubit<ShowHideSignupReenterPasswordState> {
  ShowHideSignupReenterPasswordCubit()
      : super(
            ShowHideSignupReenterPasswordState(isReEnterPasswordEnabled: true));
  listenChange(bool data) {
    emit(state.copyWith(data));
  }
}
