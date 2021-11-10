import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favouriteselectiondialogbox_state.dart';

class FavouriteselectiondialogboxCubit
    extends Cubit<FavouriteselectiondialogboxState> {
  FavouriteselectiondialogboxCubit()
      : super(FavouriteselectiondialogboxState());

  initialValue(List l1, String? l2) {
    if (l1.contains(l2)) {
      print('nnn checking val $l1  $l2 true');
      emit(state.copyWith(tapList: l1, v: true));
    } else {
      print('nnn checking val $l1  $l2 false');
      emit(state.copyWith(tapList: l1, v: false));
    }
  }
}
