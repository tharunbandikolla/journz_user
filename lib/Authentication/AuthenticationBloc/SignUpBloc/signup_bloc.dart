import 'dart:async';

import '/Common/Screens/MpinWidget.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
          event.resetOtp,
          event.firstName,
          event.lastName,
          event.name,
          event.userName,
          event.mobileNumber,
          event.token,
          event.email,
          event.password,
          event.countryName,
          event.countryCode,
          event.context);
    }
  }
  //yield SignupUploadedState();

}
