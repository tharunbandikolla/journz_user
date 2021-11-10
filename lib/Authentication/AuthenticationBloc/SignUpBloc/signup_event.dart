part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupDataCollectionEvent extends SignupEvent {}

class SignupDataUploadEvent extends SignupEvent {
  String firstName;
  MpinAddDeleteController? resetOtp;
  String lastName;
  String userName;
  String email, password;
  String mobileNumber, token, name, countryName, countryCode;

  BuildContext context;

  SignupDataUploadEvent(
      {required this.firstName,
      required this.lastName,
      required this.context,
      required this.token,
      required this.resetOtp,
      required this.name,
      required this.userName,
      required this.email,
      required this.password,
      required this.mobileNumber,
      required this.countryCode,
      required this.countryName});

  @override
  List<Object> get props =>
      [context, userName, name, email, password, mobileNumber];
}
