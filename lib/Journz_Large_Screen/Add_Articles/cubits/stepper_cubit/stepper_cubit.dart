import 'package:bloc/bloc.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  StepperCubit() : super(StepperState(steps: 1));

  trackSteps(int tracker) {
    emit(state.copyWith(tracker));
  }
}
