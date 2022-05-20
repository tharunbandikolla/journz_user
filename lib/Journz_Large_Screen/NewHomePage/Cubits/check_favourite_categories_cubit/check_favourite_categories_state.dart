part of 'check_favourite_categories_cubit.dart';

class CheckFavouriteCategoriesState {
  List<dynamic> selectedCategories = [];
  CheckFavouriteCategoriesState({required this.selectedCategories});

  CheckFavouriteCategoriesState copyWith(List<dynamic> data) {
    return CheckFavouriteCategoriesState(selectedCategories: data);
  }
}
