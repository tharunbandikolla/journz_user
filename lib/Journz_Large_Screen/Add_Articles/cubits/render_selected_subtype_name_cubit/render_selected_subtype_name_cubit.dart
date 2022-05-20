import 'package:bloc/bloc.dart';
part 'render_selected_subtype_name_state.dart';

class RenderSelectedSubtypeNameCubit
    extends Cubit<RenderSelectedSubtypeNameState> {
  RenderSelectedSubtypeNameCubit() : super(RenderSelectedSubtypeNameState());

  getSelectedSubtype(String? val) {
    emit(state.copyWith(val));
  }
}
