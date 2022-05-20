part of 'add_link_url_cubit.dart';

@immutable
class AddLinkUrlState {
  bool isLinkTapped;
  AddLinkUrlState({required this.isLinkTapped});

  AddLinkUrlState copyWith({required bool val}) {
    return AddLinkUrlState(isLinkTapped: val);
  }
}
