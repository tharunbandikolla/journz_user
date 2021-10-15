import 'package:bloc/bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'sharedpref_state.dart';

class SharedprefCubit extends Cubit<SharedprefState> {
  var p;
  SharedprefCubit(this.p) : super(SharedprefState(pref: p));

  getSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    emit(state.copyWith(preferences: pref));
  }
}
