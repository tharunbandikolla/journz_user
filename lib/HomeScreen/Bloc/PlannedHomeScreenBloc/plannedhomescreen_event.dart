part of 'plannedhomescreen_bloc.dart';

abstract class PlannedhomescreenEvent extends Equatable {
  const PlannedhomescreenEvent();

  @override
  List<Object> get props => [];
}

class GetArticleSubtypeForHomeScreen extends PlannedhomescreenEvent {}

class GetArticleForHomeScreen extends PlannedhomescreenEvent {
  List<ArticlesSubtypeModel>? articleSubtypeList = [];
  GetArticleForHomeScreen({this.articleSubtypeList});
}

class GetFavouriteArticleForHomeScreen extends PlannedhomescreenEvent {
  List<ArticlesSubtypeModel>? subtype = [];
  List<DocumentSnapshot>? article = [];
  int? docLength;
  DocumentSnapshot? lastdoc;
  GetFavouriteArticleForHomeScreen(
      {this.article, this.docLength, this.lastdoc, this.subtype});
}
