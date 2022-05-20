import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pass_gender_cubit_state.dart';

class PassGenderCubit extends Cubit<PassGenderState> {
  PassGenderCubit() : super(PassGenderState(genderdata: "Male"));

  whatGender(String val) {
    emit(state.copyWith(val));
  }
}
