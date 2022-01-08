part of 'pass_country_search_text_cubit.dart';

class PassCountrySearchTextState {
  final String? searchText;
  const PassCountrySearchTextState({this.searchText});

  PassCountrySearchTextState copyWith(String val) {
    return PassCountrySearchTextState(searchText: val);
  }
}
