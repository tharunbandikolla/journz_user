import 'package:bloc/bloc.dart';

part 'selectedcategory_state.dart';

class SelectedcategoryCubit extends Cubit<SelectedcategoryState> {
  SelectedcategoryCubit(List<dynamic> favList)
      : super(SelectedcategoryState(
            selectedCategory: favList.isNotEmpty ? "Favourites" : "All"));

  getSelectedCategory(String category) {
    emit(state.copyWith(selected: category));
  }
}
