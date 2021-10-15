import 'package:bloc/bloc.dart';

part 'testsliver_state.dart';

class TestsliverCubit extends Cubit<TestsliverState> {
  TestsliverCubit() : super(TestsliverState(photoUrl: 0));

  setImagePath(int? path) {
    print('nnnn cubit $path');
    emit(state.copyWith(photo: path));
  }
}
