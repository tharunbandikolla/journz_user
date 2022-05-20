part of 'show_hide_signup_reenter_password_cubit.dart';

class ShowHideSignupReenterPasswordState {
  final bool isReEnterPasswordEnabled;
  const ShowHideSignupReenterPasswordState(
      {required this.isReEnterPasswordEnabled});

  ShowHideSignupReenterPasswordState copyWith(bool val) {
    return ShowHideSignupReenterPasswordState(isReEnterPasswordEnabled: val);
  }
}
