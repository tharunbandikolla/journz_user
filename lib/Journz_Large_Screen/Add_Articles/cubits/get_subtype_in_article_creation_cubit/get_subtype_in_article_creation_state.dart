part of 'get_subtype_in_article_creation_cubit.dart';

class GetSubtypeInArticleCreationState {
  final List<String>? subtypes;
  GetSubtypeInArticleCreationState({required this.subtypes});

  GetSubtypeInArticleCreationState copyWith(List<String> data) {
    return GetSubtypeInArticleCreationState(subtypes: data);
  }
}
