part of 'checkuserlogined_cubit.dart';

class CheckuserloginedState extends Equatable {
  bool? isLoggined;
  CheckuserloginedState({required this.isLoggined});

  CheckuserloginedState copyWith({bool? checkLogin}) {
    return CheckuserloginedState(isLoggined: checkLogin ?? this.isLoggined);
  }

  @override
  List<Object> get props => [];
}
