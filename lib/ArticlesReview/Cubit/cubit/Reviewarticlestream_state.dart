part of 'Reviewarticlestream_cubit.dart';

class ReviewarticlestreamState {
  Stream? postedArticleStream;
  ReviewarticlestreamState({this.postedArticleStream});
  ReviewarticlestreamState copyWith({Stream? stream}) {
    return ReviewarticlestreamState(
        postedArticleStream: stream ?? this.postedArticleStream);
  }
}
