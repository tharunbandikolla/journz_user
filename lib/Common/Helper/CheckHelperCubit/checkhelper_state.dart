part of 'checkhelper_cubit.dart';
/*
class CheckhelperState extends Equatable {
  bool? title;
  bool? desc;
  bool? body;
  bool? error;
  bool? state;
  CheckhelperState({this.body, this.desc, this.error, this.title, this.state});

  CheckhelperState copyWith(
      {bool? body1, bool? desc1, bool? error1, bool? title1, bool? state1}) {
    print('nnnnn state cu $title1');
    return CheckhelperState(
        state: state1, body: body1, desc: desc1, error: error1, title: title1);
  }

  @override
  List<Object> get props => [title!, desc!, error!, body!];
}
*/

class CheckhelperState extends Equatable {
  String? title;
  String? desc;
  String? body;
  String? error;
  String? state;
  CheckhelperState({this.body, this.desc, this.error, this.title, this.state});

  CheckhelperState copyWith(
      {String? body1,
      String? desc1,
      String? error1,
      String? title1,
      String? state1}) {
    print('nnnnn state cu $title1');
    return CheckhelperState(
        state: state1, body: body1, desc: desc1, error: error1, title: title1);
  }

  @override
  List<Object> get props => [
        title ?? 'no data 1',
        desc ?? 'no data 1',
        error ?? 'no data 1',
        body ?? 'no data 1',
        state ?? 'no data 1'
      ];
}
