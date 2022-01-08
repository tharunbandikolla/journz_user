part of 'select_country_at_signup_cubit.dart';

class SelectCountryAtSignupState {
  final String? selectedCountry;
  final String? selectedCountryCode;
  const SelectCountryAtSignupState(
      {this.selectedCountry, this.selectedCountryCode});

  SelectCountryAtSignupState copyWith(String val1, String val2) {
    return SelectCountryAtSignupState(
        selectedCountry: val1, selectedCountryCode: val2);
  }
}
