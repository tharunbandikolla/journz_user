import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Authentication/DataServices/SignupDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState());

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupDataUploadEvent) {
      print('nnn entered to bloc');
      SignupDataBase().createUserWithEmailAndPassword(
          event.userCredential,
          event.firstName,
          event.lastName,
          event.name,
          event.userName,
          event.mobileNumber,
          event.token,
          event.credential,
          event.email,
          event.password,
          event.context);
    }
  }
  //yield SignupUploadedState();

}
