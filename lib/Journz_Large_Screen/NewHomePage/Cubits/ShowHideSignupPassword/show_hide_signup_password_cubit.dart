import 'package:bloc/bloc.dart';

part 'show_hide_signup_password_state.dart';

class ShowHideSignupPasswordCubit extends Cubit<ShowHideSignupPasswordState> {
  ShowHideSignupPasswordCubit()
      : super(ShowHideSignupPasswordState(isPasswordEnabled: true));

  listenChange(bool data) {
    emit(state.copyWith(data));
  }
}
