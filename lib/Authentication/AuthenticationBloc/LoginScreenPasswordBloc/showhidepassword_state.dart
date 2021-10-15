part of 'showhidepassword_cubit.dart';

class ShowHidePasswordState extends Equatable {
  bool showHidePassWord;
  ShowHidePasswordState({required this.showHidePassWord});

  ShowHidePasswordState copyWith({bool? boolean}) {
    return ShowHidePasswordState(
        showHidePassWord: boolean ?? this.showHidePassWord);
    //return SarveshInitial(data: data ?? this.data);
  }

  @override
  List<Object> get props => [showHidePassWord];
}
