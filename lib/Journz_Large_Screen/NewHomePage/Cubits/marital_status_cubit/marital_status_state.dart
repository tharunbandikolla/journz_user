part of 'marital_status_cubit.dart';

class MaritalStatusState {
  String? marital;

  MaritalStatusState({this.marital});

  MaritalStatusState copyWith(String data) {
    return MaritalStatusState(marital: data);
  }
}
