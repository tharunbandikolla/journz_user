part of 'pass_verification_id_cubit.dart';

class PassVerificationIdState {
  final String? veridicationId;
  const PassVerificationIdState({this.veridicationId});

  PassVerificationIdState copWith(String data) {
    return PassVerificationIdState(veridicationId: data);
  }
}
