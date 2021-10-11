part of 'showhidepasswordinsignup_cubit.dart';

class ShowhidepasswordinsignupState extends Equatable {
  bool passWordInSignup;
  ShowhidepasswordinsignupState({required this.passWordInSignup});
  ShowhidepasswordinsignupState copyWith({bool? boolean}) {
    return ShowhidepasswordinsignupState(
        passWordInSignup: boolean ?? this.passWordInSignup);
  }

  @override
  List<Object> get props => [passWordInSignup];
}
