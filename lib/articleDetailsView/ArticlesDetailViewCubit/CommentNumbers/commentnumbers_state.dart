part of 'commentnumbers_cubit.dart';

class CommentnumbersState {
  String? noOfComment;
  CommentnumbersState({required this.noOfComment});

  CommentnumbersState copyWith(String commentNos) {
    return CommentnumbersState(noOfComment: commentNos);
  }
}
