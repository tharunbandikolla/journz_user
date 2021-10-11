part of 'articlereport_cubit.dart';

class ArticlereportState extends Equatable {
  bool isReported = false;
  ArticlereportState({required this.isReported});
  ArticlereportState copyWith({bool? reportedBool}) {
    return ArticlereportState(isReported: reportedBool ?? this.isReported);
  }

  @override
  List<Object> get props => [isReported];
}
