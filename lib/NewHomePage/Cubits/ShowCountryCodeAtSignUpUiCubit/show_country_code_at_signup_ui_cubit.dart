import 'package:bloc/bloc.dart';

part 'show_country_code_at_signup_ui_state.dart';

class ShowCountryCodeAtSignupUiCubit
    extends Cubit<ShowCountryCodeAtSignupUiState> {
  ShowCountryCodeAtSignupUiCubit()
      : super(ShowCountryCodeAtSignupUiState(code: "+91", country: "India"));

  listenForCountryCode(String data, String val) {
    emit(state.copyWith(data, val));
  }
}
