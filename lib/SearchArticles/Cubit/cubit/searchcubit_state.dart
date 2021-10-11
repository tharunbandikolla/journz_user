part of 'searchcubit_cubit.dart';

class SearchcubitState {
  String? search;
  SearchcubitState({this.search});

  SearchcubitState copyWith({String? val}) {
    return SearchcubitState(search: val ?? this.search);
  }
}
