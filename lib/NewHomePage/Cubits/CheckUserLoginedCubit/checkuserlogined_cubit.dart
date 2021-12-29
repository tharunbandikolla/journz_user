import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'checkuserlogined_state.dart';

class CheckuserloginedCubit extends Cubit<CheckuserloginedState> {
  CheckuserloginedCubit() : super(CheckuserloginedState(isLoggined: false));

  checkLogin() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;
    //print('nnn listen User $user ');
    if (user == null) {
      emit(state.copyWith(checkLogin: false));
    } else {
      FirebaseFirestore.instance
          .collection('UserProfile')
          .doc(user.uid)
          .get()
          .then((value) async {
        emit(state.copyWith(
            checkLogin: true,
            em: await value.data()!['Email'],
            nme: await value.data()!['Name'],
            pUrl: await value.data()!['PhotoUrl'],
            uUid: await value.data()!['UserUid']));
      });
    }
  }
}
