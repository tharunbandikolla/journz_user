part of 'show_hide_login_password_cubit.dart';

class ShowHideLoginPasswordState {
  final bool visibleOff;
  const ShowHideLoginPasswordState({required this.visibleOff});

  ShowHideLoginPasswordState copyWith(bool data) {
    return ShowHideLoginPasswordState(visibleOff: data);
  }
}
