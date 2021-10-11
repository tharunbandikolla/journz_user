part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupDataCollectionEvent extends SignupEvent {}

class SignupDataUploadEvent extends SignupEvent {
  UserCredential userCredential;
  String firstName;
  String lastName;
  String userName;
  String email, password;
  String mobileNumber, token, name;
  PhoneAuthCredential credential;
  BuildContext context;

  SignupDataUploadEvent({
    required this.userCredential,
    required this.firstName,
    required this.lastName,
    required this.context,
    required this.token,
    required this.name,
    required this.userName,
    required this.email,
    required this.password,
    required this.credential,
    required this.mobileNumber,
  });

  @override
  List<Object> get props =>
      [context, userName, name, email, password, mobileNumber];
}
