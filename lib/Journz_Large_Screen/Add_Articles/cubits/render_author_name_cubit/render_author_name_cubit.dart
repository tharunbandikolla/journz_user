import 'package:bloc/bloc.dart';

part 'render_author_name_state.dart';

class RenderAuthorNameCubit extends Cubit<RenderAuthorNameState> {
  RenderAuthorNameCubit() : super(RenderAuthorNameState(authorName: null));

  renderAuthorName(String? name) {
    print('nnnn $name');
    emit(state.copyWith(val: name));
  }
}
