import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:journz_web/HiveArticlesModel/ArticleModel/hive_article_data.dart';

import 'package:journz_web/HiveArticlesModel/hive_articles_title_pref.dart';
import 'package:journz_web/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_articles_from_cloud_state.dart';

class GetArticlesFromCloudCubit extends Cubit<GetArticlesFromCloudState> {
  GetArticlesFromCloudCubit() : super(GetArticlesFromCloudState());

  getArticlesfromCloud() {
    SharedPreferences.getInstance().then((preference) async {
      final articleFromBox = Boxes.getArticleFromCloud();
      List<String>? articleTitleFromPref =
          await HiveArticlesTitlePreferences().getArticleTitle(preference);
      List<dynamic> articleTitles = [];
      if (articleTitleFromPref != null) {
        if (articleTitleFromPref.length == articleFromBox.length) {
          FirebaseFirestore.instance
              .collection('NewArticleCollection')
              .get()
              .then((value) async {
            value.docs.forEach((element) async {
              if (articleTitleFromPref
                  .contains(await element.data()['ArticleTitle'])) {
              } else {
                articleTitles.add(await element.data()['ArticleTitle']);
                HiveArticlesTitlePreferences()
                    .setArticleTitles(preference, articleTitles);
                final data = HiveArticleData()
                  ..articleTitle = await element.data()['ArticleTitle']
                  ..articleDescription =
                      await element.data()['ArticleDescription']
                  ..articleLike = await element.data()['ArticleLike']
                  ..articlePhotoUrl = await element.data()['ArticlePhotoUrl']
                  ..articleSubtype = await element.data()['ArticleSubtype']
                  ..authorName = await element.data()['AuthorName']
                  ..authorUid = await element.data()['AuthorUid']
                  ..bookmarkedBy = await element.data()['BookmarkedBy']
                  ..country = await element.data()['Country']
                  ..documentId = await element.data()['DocumentId']
                  ..galleryImages = await element.data()['GalleryImages']
                  ..isArticlePublished =
                      await element.data()['IsArticlePublished']
                  ..isArticleReported =
                      await element.data()['IsArticleReported']
                  ..noOfComments = await element.data()['NoOfComments']
                  ..noOflikes = await element.data()['NoOfLikes']
                  ..noOfViews = await element.data()['NoOfViews']
                  ..articleReportedBy =
                      await element.data()['ArticleReportedBy']
                  ..socialMediaLink = await element.data()['SocialMedialink'];

                articleFromBox.add(data);
              }
            });
          });
        } else {
          HiveArticlesTitlePreferences().setArticleTitles(preference, []);
          articleFromBox.clear();

          FirebaseFirestore.instance
              .collection('NewArticleCollection')
              .get()
              .then((value) async {
            value.docs.forEach((e) async {
              articleTitles.add(await e.data()['ArticleTitle']);
              HiveArticlesTitlePreferences()
                  .setArticleTitles(preference, articleTitles);

              final data = HiveArticleData()
                ..articleTitle = await e.data()['ArticleTitle']
                ..articleDescription = await e.data()['ArticleDescription']
                ..articleLike = await e.data()['ArticleLike']
                ..articlePhotoUrl = await e.data()['ArticlePhotoUrl']
                ..articleSubtype = await e.data()['ArticleSubtype']
                ..authorName = await e.data()['AuthorName']
                ..authorUid = await e.data()['AuthorUid']
                ..bookmarkedBy = await e.data()['BookmarkedBy']
                ..country = await e.data()['Country']
                ..documentId = await e.data()['DocumentId']
                ..galleryImages = await e.data()['GalleryImages']
                ..isArticlePublished = await e.data()['IsArticlePublished']
                ..isArticleReported = await e.data()['IsArticleReported']
                ..noOfComments = await e.data()['NoOfComments']
                ..noOflikes = await e.data()['NoOfLikes']
                ..noOfViews = await e.data()['NoOfViews']
                ..articleReportedBy = await e.data()['ArticleReportedBy']
                ..socialMediaLink = await e.data()['SocialMedialink'];

              articleFromBox.add(data);
            });
          });
        }
      } else {
        HiveArticlesTitlePreferences().setArticleTitles(preference, []);
        articleFromBox.clear();

        FirebaseFirestore.instance
            .collection('NewArticleCollection')
            .get()
            .then((value) async {
          value.docs.forEach((element) async {
            articleTitles.add(await element.data()['ArticleTitle']);
            HiveArticlesTitlePreferences()
                .setArticleTitles(preference, articleTitles);

            final data = HiveArticleData()
              ..articleTitle = await element.data()['ArticleTitle']
              ..articleDescription = await element.data()['ArticleDescription']
              ..articleLike = await element.data()['ArticleLike']
              ..articlePhotoUrl = await element.data()['ArticlePhotoUrl']
              ..articleSubtype = await element.data()['ArticleSubtype']
              ..authorName = await element.data()['AuthorName']
              ..authorUid = await element.data()['AuthorUid']
              ..bookmarkedBy = await element.data()['BookmarkedBy']
              ..country = await element.data()['Country']
              ..documentId = await element.data()['DocumentId']
              ..galleryImages = await element.data()['GalleryImages']
              ..isArticlePublished = await element.data()['IsArticlePublished']
              ..isArticleReported = await element.data()['IsArticleReported']
              ..noOfComments = await element.data()['NoOfComments']
              ..noOflikes = await element.data()['NoOfLikes']
              ..noOfViews = await element.data()['NoOfViews']
              ..articleReportedBy = await element.data()['ArticleReportedBy']
              ..socialMediaLink = await element.data()['SocialMedialink'];

            articleFromBox.add(data);
          });
        });
      }
    });
  }
}
