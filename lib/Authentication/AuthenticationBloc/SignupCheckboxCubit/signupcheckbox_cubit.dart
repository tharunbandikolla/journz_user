import 'package:bloc/bloc.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

part 'signupcheckbox_state.dart';

class SignupcheckboxCubit extends Cubit<SignupcheckboxState> {
  SignupcheckboxCubit() : super(SignupcheckboxState(check: false));

  checkToggle(bool? checkBox) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      //value;
      emit(state.copyWith(getBool: checkBox, tok: value));
    });
  }
}
