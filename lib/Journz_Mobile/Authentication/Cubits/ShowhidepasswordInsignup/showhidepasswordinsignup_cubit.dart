import 'package:bloc/bloc.dart';

part 'showhidepasswordinsignup_state.dart';

class ShowhidepasswordinsignupCubit
    extends Cubit<ShowhidepasswordinsignupState> {
  bool passwordBool = false;
  ShowhidepasswordinsignupCubit()
      : super(ShowhidepasswordinsignupState(passWordInSignup: true));

  updateSignUpPasswordBool(bool val) {
    passwordBool = val;
    emit(state.copyWith(boolean: passwordBool));
  }
}
