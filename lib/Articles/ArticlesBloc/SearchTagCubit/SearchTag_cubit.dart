import 'package:bloc/bloc.dart';

part 'SearchTag_state.dart';

class SearchTagCubit extends Cubit<SearchTagState> {
  List<String> categoryList = [];
  SearchTagCubit() : super(SearchTagState(category: []));

  addDataToCategoryList(String val) {
    print('nnn val coming $val');
    categoryList.add(val);
    emit(state.copyWith(subType: categoryList));
  }

  removeDataFromCategoryList(String val) {
    categoryList.remove(val);
    emit(state.copyWith(subType: categoryList));
  }
}
