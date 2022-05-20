import 'package:bloc/bloc.dart';
part 'select_country_at_signup_state.dart';

class SelectCountryAtSignupCubit extends Cubit<SelectCountryAtSignupState> {
  String? countryCode, countryName;
  SelectCountryAtSignupCubit({this.countryCode, this.countryName})
      : super(SelectCountryAtSignupState(
            selectedCountry: countryName ?? 'India',
            selectedCountryCode: countryCode ?? "+91"));

  listenSelectedCountry(String name, String code) {
    emit(state.copyWith(name, code));
  }
}
