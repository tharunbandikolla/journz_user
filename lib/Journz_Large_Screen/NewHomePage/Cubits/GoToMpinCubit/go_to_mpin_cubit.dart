import 'package:bloc/bloc.dart';
part 'go_to_mpin_state.dart';

class GoToMpinCubit extends Cubit<GoToMpinState> {
  GoToMpinCubit() : super(GoToMpinState(task: 0));

  listenForTask(int v) {
    emit(state.copyWith(v));
  }
}
