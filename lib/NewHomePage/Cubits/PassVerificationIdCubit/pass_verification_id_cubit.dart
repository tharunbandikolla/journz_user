import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pass_verification_id_state.dart';

class PassVerificationIdCubit extends Cubit<PassVerificationIdState> {
  PassVerificationIdCubit() : super(PassVerificationIdState());

  listenForVerificationId(String verificationId) {
    emit(state.copWith(verificationId));
  }
}
