part of 'countdown_cubit.dart';

class CountdownState {
  int? time;
  Timer? isEndedTimer;
  bool? isEnded;

  CountdownState({this.time, this.isEnded, this.isEndedTimer});

  CountdownState copyWith({int? t, Timer? endTimer, bool? end}) {
    return CountdownState(
        time: t ?? this.time, isEnded: end, isEndedTimer: endTimer);
  }
}
