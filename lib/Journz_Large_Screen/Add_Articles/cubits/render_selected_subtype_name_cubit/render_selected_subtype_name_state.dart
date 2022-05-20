part of 'render_selected_subtype_name_cubit.dart';

class RenderSelectedSubtypeNameState {
  String? selectedSubtype;
  RenderSelectedSubtypeNameState({this.selectedSubtype});

  RenderSelectedSubtypeNameState copyWith(String? name) {
    return RenderSelectedSubtypeNameState(
        selectedSubtype: name ?? selectedSubtype);
  }
}
