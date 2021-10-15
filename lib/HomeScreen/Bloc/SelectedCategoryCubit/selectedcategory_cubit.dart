import 'package:bloc/bloc.dart';

part 'selectedcategory_state.dart';

class SelectedcategoryCubit extends Cubit<SelectedcategoryState> {
  SelectedcategoryCubit()
      : super(SelectedcategoryState(selectedCategory: 'All'));

  getSelectedCategory(String category) {
    emit(state.copyWith(selected: category));
  }
}
