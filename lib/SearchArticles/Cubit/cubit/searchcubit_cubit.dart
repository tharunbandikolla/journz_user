import 'package:bloc/bloc.dart';

part 'searchcubit_state.dart';

class SearchcubitCubit extends Cubit<SearchcubitState> {
  SearchcubitCubit() : super(SearchcubitState(search: null));

  getSearchText(String text) {
    emit(state.copyWith(val: text));
  }
}
