import 'package:bloc/bloc.dart';

part 'show_currently_selected_subtype_state.dart';

class ShowCurrentlySelectedSubtypeCubit
    extends Cubit<ShowCurrentlySelectedSubtypeState> {
  bool userState;
  ShowCurrentlySelectedSubtypeCubit({required this.userState})
      : super(ShowCurrentlySelectedSubtypeState(
            selectedSubtype: userState ? "Favourites" : "All"));

  changeSelectedSubtypeTo(String val) {
    emit(state.copyWith(data: val));
  }
}
