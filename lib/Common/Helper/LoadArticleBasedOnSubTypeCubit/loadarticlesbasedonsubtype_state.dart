part of 'loadarticlesbasedonsubtype_cubit.dart';

class LoadarticlesbasedonsubtypeState {
  String? category;
  List<DocumentSnapshot>? data;
  LoadarticlesbasedonsubtypeState({this.category, this.data});

  LoadarticlesbasedonsubtypeState copyWith(
      {required String cat, required List<DocumentSnapshot> articlesData}) {
    return LoadarticlesbasedonsubtypeState(category: cat, data: articlesData);
  }
}
