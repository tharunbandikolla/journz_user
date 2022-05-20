import 'package:bloc/bloc.dart';
part 'show_hide_login_password_state.dart';

class ShowHideLoginPasswordCubit extends Cubit<ShowHideLoginPasswordState> {
  ShowHideLoginPasswordCubit()
      : super(ShowHideLoginPasswordState(visibleOff: true));

  getvisibility(bool val) {
    emit(state.copyWith(val));
  }
}
