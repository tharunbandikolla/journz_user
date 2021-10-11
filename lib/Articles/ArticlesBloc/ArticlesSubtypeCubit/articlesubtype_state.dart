part of 'articlesubtype_cubit.dart';

class ArticlesubtypeState extends Equatable {
  List<String>? subtype;
  String? authorName, authorUid;
  int? noOfArticlesUnderCategory;
  int? noOfArticlesPostedByAuthor;
  ArticlesubtypeState(
      {this.subtype,
      this.authorName,
      this.authorUid,
      this.noOfArticlesPostedByAuthor,
      this.noOfArticlesUnderCategory});

  ArticlesubtypeState copyWith(
      {List<String>? list,
      String? name,
      String? uid,
      int? nos,
      int? noOfArticlesPosted}) {
    return ArticlesubtypeState(
        noOfArticlesUnderCategory: nos ?? this.noOfArticlesUnderCategory,
        subtype: list ?? this.subtype,
        authorName: name ?? this.authorName,
        noOfArticlesPostedByAuthor:
            noOfArticlesPosted ?? this.noOfArticlesPostedByAuthor,
        authorUid: uid ?? this.authorUid);
  }

  @override
  List<Object> get props => [
        this.subtype!,
        this.authorName!,
        this.authorUid!,
        noOfArticlesUnderCategory!
      ];
}
