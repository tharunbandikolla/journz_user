part of 'loaddatapartbypart_cubit.dart';

class LoaddatapartbypartState {
  List<DocumentSnapshot>? splitedData;
  DocumentSnapshot? lastDoc;
  int? docLength;
  LoaddatapartbypartState({this.splitedData, this.lastDoc, this.docLength});

  LoaddatapartbypartState copyWith(
      {List<DocumentSnapshot>? data, DocumentSnapshot? doc, int? nos}) {
    return LoaddatapartbypartState(
        splitedData: data ?? this.splitedData,
        lastDoc: doc ?? this.lastDoc,
        docLength: nos ?? this.docLength);
  }
}
