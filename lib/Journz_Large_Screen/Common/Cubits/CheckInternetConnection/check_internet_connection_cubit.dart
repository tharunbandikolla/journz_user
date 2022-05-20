import 'package:bloc/bloc.dart';

part 'check_internet_connection_state.dart';

class CheckInternetConnectionCubit extends Cubit<CheckInternetConnectionState> {
  CheckInternetConnectionCubit()
      : super(CheckInternetConnectionState(streamInternet: null));

  listenForInternet() async {}
}
