import 'package:bloc/bloc.dart';

import '/ArticlesReview/DataService/ReviewArticleDataBase.dart';

part 'Reviewarticlestream_state.dart';

class ReviewarticlestreamCubit extends Cubit<ReviewarticlestreamState> {
  ReviewarticlestreamCubit() : super(ReviewarticlestreamState());

  getPostedArticleStream() async {
    Stream postedArticleStream =
        await ReviewArticleDataBase().getPostedArticlesStream();
    emit(state.copyWith(stream: postedArticleStream));
  }
}
