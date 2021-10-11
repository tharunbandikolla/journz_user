part of 'authorrequest_cubit.dart';

class AuthorrequestState {
  String? isRequested;
  AuthorrequestState({this.isRequested});

  AuthorrequestState copyWith({String? request}) {
    return AuthorrequestState(isRequested: request ?? this.isRequested);
  }
}
