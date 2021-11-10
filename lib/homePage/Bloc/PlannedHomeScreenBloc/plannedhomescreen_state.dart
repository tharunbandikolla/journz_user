part of 'plannedhomescreen_bloc.dart';

abstract class PlannedhomescreenState extends Equatable {
  const PlannedhomescreenState();

  @override
  List<Object> get props => [];
}

class PlannedhomescreenInitial extends PlannedhomescreenState {}

class ShowArticleSubtypeState extends PlannedhomescreenState {
  List<ArticlesSubtypeModel>? SubTypeList = [];
  ShowArticleSubtypeState({this.SubTypeList});
  ShowArticleSubtypeState copyWith(List<ArticlesSubtypeModel>? categoryList) {
    return ShowArticleSubtypeState(
        SubTypeList: categoryList ?? this.SubTypeList);
  }
}

class ShowArticleState extends PlannedhomescreenState {
  List<ArticlesSubtypeModel>? articleSubtypeList = [];
  List<DocumentSnapshot>? splitedData;
  DocumentSnapshot? lastDoc;
  int? docLength;
  ShowArticleState(
      {this.articleSubtypeList,
      this.splitedData,
      this.lastDoc,
      this.docLength});

  ShowArticleState copyWith(
      {List<ArticlesSubtypeModel>? subtype,
      List<DocumentSnapshot>? someData,
      DocumentSnapshot? snap,
      int? length}) {
    return ShowArticleState(
        articleSubtypeList: subtype ?? this.articleSubtypeList,
        docLength: length ?? this.docLength,
        lastDoc: snap ?? this.lastDoc,
        splitedData: someData ?? this.splitedData);
  }
}

class ShowFavouriteArticleState extends PlannedhomescreenState {
  List<ArticlesSubtypeModel>? subtype = [];
  List<DocumentSnapshot>? article = [];
  int? docLength;
  DocumentSnapshot? lastdoc;
  List<dynamic>? favouriteArticle = [];
  String? country;
  ShowFavouriteArticleState(
      {this.article,
      this.country,
      this.docLength,
      this.favouriteArticle,
      this.lastdoc,
      this.subtype});

  ShowFavouriteArticleState copyWith(
      {List<DocumentSnapshot>? articles,
      List<ArticlesSubtypeModel>? subtype,
      int? length,
      DocumentSnapshot? snap,
      List<dynamic>? favouriteArticle}) {
    return ShowFavouriteArticleState(
        article: articles ?? this.article,
        docLength: length ?? docLength,
        favouriteArticle: favouriteArticle ?? this.favouriteArticle,
        lastdoc: snap ?? this.lastdoc,
        subtype: subtype ?? this.subtype);
  }
}
