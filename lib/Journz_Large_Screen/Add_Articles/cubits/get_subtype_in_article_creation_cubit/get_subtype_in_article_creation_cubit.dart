import 'package:bloc/bloc.dart';

part 'get_subtype_in_article_creation_state.dart';

class GetSubtypeInArticleCreationCubit
    extends Cubit<GetSubtypeInArticleCreationState> {
  GetSubtypeInArticleCreationCubit()
      : super(GetSubtypeInArticleCreationState(subtypes: []));

  getData(List<String> d) {
    emit(state.copyWith(d));
  }
}
