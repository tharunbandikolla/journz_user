import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'agree_terms_conditions_state.dart';

class AgreeTermsConditionsCubit extends Cubit<AgreeTermsConditionsState> {
  AgreeTermsConditionsCubit() : super(AgreeTermsConditionsState(agree: true));

  listenForAcceptance(bool data) {
    emit(state.copyWith(data));
  }
}
