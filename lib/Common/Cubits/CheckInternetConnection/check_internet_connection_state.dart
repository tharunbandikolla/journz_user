part of 'check_internet_connection_cubit.dart';

class CheckInternetConnectionState {
  bool? streamInternet;
  CheckInternetConnectionState({required this.streamInternet});

  CheckInternetConnectionState copyWith(bool streamNet) {
    print('internet connectivity emit cubit $streamNet');
    return CheckInternetConnectionState(streamInternet: streamNet);
  }
}
