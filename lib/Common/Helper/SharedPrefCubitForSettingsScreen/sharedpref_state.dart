part of 'sharedpref_cubit.dart';

class SharedprefState {
  SharedPreferences pref;
  SharedprefState({required this.pref});
  SharedprefState copyWith({required SharedPreferences preferences}) {
    return SharedprefState(pref: preferences);
  }
}
