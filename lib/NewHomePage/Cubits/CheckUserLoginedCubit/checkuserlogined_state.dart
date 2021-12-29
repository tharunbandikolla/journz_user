// ignore_for_file: must_be_immutable

part of 'checkuserlogined_cubit.dart';

class CheckuserloginedState {
  bool? isLoggined;
  String? name, email, photoUrl, userUid;
  CheckuserloginedState(
      {required this.isLoggined,
      this.email,
      this.name,
      this.photoUrl,
      this.userUid});

  CheckuserloginedState copyWith(
      {bool? checkLogin, String? nme, String? em, String? pUrl, String? uUid}) {
    return CheckuserloginedState(
        isLoggined: checkLogin ?? this.isLoggined,
        email: em,
        name: nme,
        photoUrl: pUrl,
        userUid: uUid);
  }
}
