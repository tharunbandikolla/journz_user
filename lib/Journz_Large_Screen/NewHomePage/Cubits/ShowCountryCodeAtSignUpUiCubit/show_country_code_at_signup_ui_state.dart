part of 'show_country_code_at_signup_ui_cubit.dart';

class ShowCountryCodeAtSignupUiState {
  final String code;
  final String country;
  const ShowCountryCodeAtSignupUiState(
      {required this.code, required this.country});

  ShowCountryCodeAtSignupUiState copyWith(String val, String data) {
    return ShowCountryCodeAtSignupUiState(code: val, country: data);
  }
}
