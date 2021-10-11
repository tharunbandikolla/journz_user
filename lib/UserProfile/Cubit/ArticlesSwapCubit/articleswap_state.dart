part of 'articleswap_cubit.dart';

class ArticleswapState extends Equatable {
  bool articlesSwap;
  ArticleswapState({required this.articlesSwap});

  ArticleswapState copyWith({required bool swapBool}) {
    return ArticleswapState(articlesSwap: swapBool);
  }

  @override
  List<Object> get props => [articlesSwap];
}
