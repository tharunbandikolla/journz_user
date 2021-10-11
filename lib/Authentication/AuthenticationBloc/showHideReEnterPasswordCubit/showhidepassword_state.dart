part of 'showhidepassword_cubit.dart';

class ShowHideReEnterPasswordState extends Equatable {
  bool showHideReEnterPassWord;
  ShowHideReEnterPasswordState({required this.showHideReEnterPassWord});

  ShowHideReEnterPasswordState copyWith({bool? boolean}) {
    return ShowHideReEnterPasswordState(
        showHideReEnterPassWord: boolean ?? this.showHideReEnterPassWord);
    //return SarveshInitial(data: data ?? this.data);
  }

  @override
  List<Object> get props => [showHideReEnterPassWord];
}
