part of 'show_hide_signup_password_cubit.dart';

class ShowHideSignupPasswordState {
  final bool isPasswordEnabled;
  const ShowHideSignupPasswordState({required this.isPasswordEnabled});

  ShowHideSignupPasswordState copyWith(bool val) {
    return ShowHideSignupPasswordState(isPasswordEnabled: val);
  }
}
