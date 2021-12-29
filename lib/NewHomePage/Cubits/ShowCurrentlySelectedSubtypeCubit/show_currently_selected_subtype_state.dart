part of 'show_currently_selected_subtype_cubit.dart';

class ShowCurrentlySelectedSubtypeState {
  String? selectedSubtype;
  ShowCurrentlySelectedSubtypeState({this.selectedSubtype});

  ShowCurrentlySelectedSubtypeState copyWith({String? data}) {
    return ShowCurrentlySelectedSubtypeState(
        selectedSubtype: data ?? selectedSubtype);
  }
}
