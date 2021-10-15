part of 'SearchTag_cubit.dart';

class SearchTagState {
  List<String>? category;
  SearchTagState({this.category});

  SearchTagState copyWith({List<String>? subType}) {
    print('nnn val going $subType');
    return SearchTagState(category: subType ?? this.category);
  }
}
