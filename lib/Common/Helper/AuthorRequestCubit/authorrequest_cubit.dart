import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authorrequest_state.dart';

class AuthorrequestCubit extends Cubit<AuthorrequestState> {
  AuthorrequestCubit() : super(AuthorrequestState(isRequested: 'False'));

  getRequest() async {
    FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((value) async {
      emit(state.copyWith(request: await value.data()!['RequestAuthor']));
    });
  }
}
