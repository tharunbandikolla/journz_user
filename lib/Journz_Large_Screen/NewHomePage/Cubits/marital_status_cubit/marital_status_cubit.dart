import 'package:bloc/bloc.dart';

part 'marital_status_state.dart';

class MaritalStatusCubit extends Cubit<MaritalStatusState> {
  MaritalStatusCubit() : super(MaritalStatusState(marital: "Single"));

  whatMarital(String val) {
    emit(state.copyWith(val));
  }
}
