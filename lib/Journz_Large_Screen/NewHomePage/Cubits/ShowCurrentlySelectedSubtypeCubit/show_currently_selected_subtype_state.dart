part of 'show_currently_selected_subtype_cubit.dart';

class ShowCurrentlySelectedSubtypeState {
  final String selectedSubtype;
  ShowCurrentlySelectedSubtypeState({required this.selectedSubtype});

  ShowCurrentlySelectedSubtypeState copyWith({required String data}) {
    return ShowCurrentlySelectedSubtypeState(selectedSubtype: data);
  }
}
