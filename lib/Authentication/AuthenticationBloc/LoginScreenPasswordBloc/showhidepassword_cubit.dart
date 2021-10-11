import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'showhidepassword_state.dart';

class ShowhidepasswordCubit extends Cubit<ShowHidePasswordState> {
  bool showHidePasswordBool = false;
  ShowhidepasswordCubit()
      : super(ShowHidePasswordState(showHidePassWord: true));

  updateShowHidePasswordBool(bool val) {
    showHidePasswordBool = val;
    emit(state.copyWith(boolean: showHidePasswordBool));
  }
}
