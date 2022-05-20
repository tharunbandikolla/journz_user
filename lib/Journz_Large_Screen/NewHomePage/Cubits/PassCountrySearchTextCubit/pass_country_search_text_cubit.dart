import 'package:bloc/bloc.dart';

part 'pass_country_search_text_state.dart';

class PassCountrySearchTextCubit extends Cubit<PassCountrySearchTextState> {
  PassCountrySearchTextCubit() : super(PassCountrySearchTextState());

  listenSearchText(String data) {
    emit(state.copyWith(data));
  }
}
