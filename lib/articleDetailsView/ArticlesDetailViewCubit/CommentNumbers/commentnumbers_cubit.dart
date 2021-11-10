import 'package:bloc/bloc.dart';

part 'commentnumbers_state.dart';

class CommentnumbersCubit extends Cubit<CommentnumbersState> {
  CommentnumbersCubit() : super(CommentnumbersState(noOfComment: '0'));

  getCommentNos(String nos) {
    emit(state.copyWith(nos));
  }
}
