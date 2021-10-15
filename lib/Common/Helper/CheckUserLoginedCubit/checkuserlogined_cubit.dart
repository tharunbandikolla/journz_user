import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'checkuserlogined_state.dart';

class CheckuserloginedCubit extends Cubit<CheckuserloginedState> {
  CheckuserloginedCubit() : super(CheckuserloginedState(isLoggined: false));

  checkLogin() {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(state.copyWith(checkLogin: true));
    } else {
      emit(state.copyWith(checkLogin: false));
    }
  }
}
