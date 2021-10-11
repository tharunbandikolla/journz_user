import 'dart:async';

import 'package:bloc/bloc.dart';

part 'countdown_state.dart';

class CountdownCubit extends Cubit<CountdownState> {
  CountdownCubit() : super(CountdownState(time: 30, isEnded: null));

  stateTimer(int timer, int period, bool isClosed) {
    Timer.periodic(Duration(seconds: period), (period) {
      print('nnnnn tickk ${period.tick}');
      if (period.tick == 29) {
        period.cancel();
        emit(state.copyWith(t: --timer, endTimer: period, end: isClosed));
      } else {
        emit(state.copyWith(t: --timer, endTimer: period, end: isClosed));
      }
    });
  }
}
