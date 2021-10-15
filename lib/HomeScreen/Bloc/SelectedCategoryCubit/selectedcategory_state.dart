part of 'selectedcategory_cubit.dart';

class SelectedcategoryState {
  String? selectedCategory;
  SelectedcategoryState({this.selectedCategory});

  SelectedcategoryState copyWith({String? selected}) {
    return SelectedcategoryState(
        selectedCategory: selected ?? this.selectedCategory);
  }
}
