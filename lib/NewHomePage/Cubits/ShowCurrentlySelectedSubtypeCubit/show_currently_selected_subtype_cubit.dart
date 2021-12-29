import 'package:bloc/bloc.dart';

part 'show_currently_selected_subtype_state.dart';

class ShowCurrentlySelectedSubtypeCubit
    extends Cubit<ShowCurrentlySelectedSubtypeState> {
  ShowCurrentlySelectedSubtypeCubit()
      : super(ShowCurrentlySelectedSubtypeState(selectedSubtype: 'All'));

  changeSelectedSubtypeTo(String val) {
    emit(state.copyWith(data: val));
  }
}
