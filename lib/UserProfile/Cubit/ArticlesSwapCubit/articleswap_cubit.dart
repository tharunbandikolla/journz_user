import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'articleswap_state.dart';

class ArticleswapCubit extends Cubit<ArticleswapState> {
  ArticleswapCubit() : super(ArticleswapState(articlesSwap: false));

  tapOnArticle() {
    emit(state.copyWith(swapBool: false));
  }

  tapOnSaved() {
    emit(state.copyWith(swapBool: true));
  }
}
