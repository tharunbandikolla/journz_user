part of 'render_author_name_cubit.dart';

class RenderAuthorNameState {
  String? authorName;
  RenderAuthorNameState({this.authorName});

  RenderAuthorNameState copyWith({String? val}) {
    return RenderAuthorNameState(authorName: val);
  }
}
