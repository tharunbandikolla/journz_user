import '/Common/Helper/CountDownCubit/countdown_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Authentication/AuthenticationBloc/SignUpBloc/signup_bloc.dart';
import '/Common/Screens/MpinPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState());

  createAccountWithMail(
      {required BuildContext context,
      required String token,
      required String name,
      required String firstName,
      required String lastName,
      required String userName,
      required String email,
      required String password,
      required String countryName,
      required String countryCode,
      required String mobileNumber}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .onError((error, stackTrace) {
      String msg = error
          .toString()
          .replaceFirst(RegExp(r'\[(.*?)\]', caseSensitive: false), '');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg.trim()),
      ));
      throw Exception(error);
    });
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignupBloc(),
                ),
                BlocProvider(
                  create: (context) => CountdownCubit(),
                ),
              ],
              child: MpinPage(
                  country: countryName,
                  countryCode: countryCode,
                  firstName: firstName,
                  lastName: lastName,
                  token: token,
                  name: name,
                  userName: userName,
                  email: email,
                  password: password,
                  mobileNumber: mobileNumber),
            ),
          ));
    });
  }
}
