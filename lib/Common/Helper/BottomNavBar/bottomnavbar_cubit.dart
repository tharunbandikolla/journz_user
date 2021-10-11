import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottomnavbar_state.dart';

class BottomnavbarCubit extends Cubit<BottomnavbarState> {
  BottomnavbarCubit() : super(BottomnavbarState(currentIndex: 0));

  setCurrentIndex(int ind) {
    print('crr inde $ind');
    emit(state.copyWith(index: ind));
  }
}
