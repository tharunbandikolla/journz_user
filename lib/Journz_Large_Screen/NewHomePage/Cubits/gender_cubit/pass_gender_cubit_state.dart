part of 'pass_gender_cubit_cubit.dart';

class PassGenderState {
  String? genderdata;
  PassGenderState({this.genderdata});

  PassGenderState copyWith(String data) {
    return PassGenderState(genderdata: data);
  }
}
