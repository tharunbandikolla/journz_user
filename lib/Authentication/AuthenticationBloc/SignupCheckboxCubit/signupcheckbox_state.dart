part of 'signupcheckbox_cubit.dart';

class SignupcheckboxState {
  bool check = false;
  String? token;
  SignupcheckboxState({required this.check, this.token});

  SignupcheckboxState copyWith({bool? getBool, String? tok}) {
    return SignupcheckboxState(
        check: getBool ?? this.check, token: tok ?? this.token);
  }
}
