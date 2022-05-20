import 'package:bloc/bloc.dart';

part 'check_favourite_categories_state.dart';

class CheckFavouriteCategoriesCubit
    extends Cubit<CheckFavouriteCategoriesState> {
  List<dynamic> initialData;
  CheckFavouriteCategoriesCubit({required this.initialData})
      : super(CheckFavouriteCategoriesState(selectedCategories: initialData));

  addOrRemoveCategories(List<dynamic> selectedList, String name) {
    if (selectedList.contains(name)) {
      selectedList.remove(name);
      emit(state.copyWith(selectedList));
    } else {
      selectedList.add(name);
      emit(state.copyWith(selectedList));
    }
  }
}
