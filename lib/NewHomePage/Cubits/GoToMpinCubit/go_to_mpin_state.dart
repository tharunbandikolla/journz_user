part of 'go_to_mpin_cubit.dart';

class GoToMpinState {
  final int task;
  const GoToMpinState({required this.task});

  GoToMpinState copyWith(int data) {
    return GoToMpinState(task: data);
  }
}
