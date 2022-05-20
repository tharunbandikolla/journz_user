part of 'stepper_cubit.dart';

class StepperState {
  int? steps;
  StepperState({this.steps});

  StepperState copyWith(int currentSteps) {
    return StepperState(steps: currentSteps);
  }
}
