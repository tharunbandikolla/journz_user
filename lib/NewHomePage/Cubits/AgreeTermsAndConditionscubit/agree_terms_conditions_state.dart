part of 'agree_terms_conditions_cubit.dart';

class AgreeTermsConditionsState {
  final bool agree;
  const AgreeTermsConditionsState({required this.agree});

  AgreeTermsConditionsState copyWith(bool val) {
    return AgreeTermsConditionsState(agree: val);
  }
}
