part of 'articletitle_cubit.dart';

class ArticletitleState extends Equatable {
  String title;
  ArticletitleState({required this.title});
  ArticletitleState copyWith({required String t}) {
    return ArticletitleState(title: t);
  }

  @override
  List<Object> get props => [title];
}
