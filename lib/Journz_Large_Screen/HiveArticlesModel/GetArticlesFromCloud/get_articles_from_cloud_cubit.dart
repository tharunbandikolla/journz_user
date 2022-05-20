import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:journz_web/Journz_Large_Screen/HiveArticlesModel/LocalArticleModel/code_article_model.dart';

import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';

import '/Journz_Large_Screen/HiveArticlesModel/hive_articles_title_pref.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_articles_from_cloud_state.dart';

class GetArticlesFromCloudCubit extends Cubit<GetArticlesFromCloudState> {
  GetArticlesFromCloudCubit() : super(GetArticlesFromCloudState());

  getArticlesfromCloud() {
    SharedPreferences.getInstance().then((pref) async {
      Box<HiveArticleData>? articleDataBox = Boxes.getArticleFromCloud();
      List<CodeArticleData> articledata = [];
      List<String>? dummyArticleList = [];
      List<String>? articleList =
          await HiveArticlesTitlePreferences().retriveArticleName(pref);
      if (await articleList != null && await articleList != []) {
        print("subtype 1");
        if (articleList!.length == articleDataBox.length) {
          print("subtype 2");
          FirebaseFirestore.instance
              .collection('NewArticleCollection')
              // .where("IsArticlePublished", isEqualTo: "Published")
              .orderBy('CreatedTime', descending: true)
              .get()
              .then((value) async {
            value.docs.forEach((e) async {
              if (articleList.contains(e.data()['ArticleTitle'])) {
              } else {
                dummyArticleList.add(await e.data()['ArticleTitle']);
                HiveArticlesTitlePreferences()
                    .storeArticleName(pref, dummyArticleList);

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
                  ..socialMediaLink = await e.data()['SocialMedialink']
                  ..shortDescription = await e.data()['ShortDescription'];

                final box = Boxes.getArticleFromCloud();

                box.add(data);
                articledata.add(CodeArticleData(
                    articleDescription: e.data()['ArticleDescription'],
                    articleLike: e.data()['ArticleLike'],
                    articlePhotoUrl: await e.data()['ArticlePhotoUrl'],
                    articleReportedBy: await e.data()['ArticleReportedBy'],
                    articleSubtype: e.data()['ArticleSubtype'],
                    articleTitle: e.data()['ArticleTitle'],
                    authorName: e.data()['AuthorName'],
                    authorUid: e.data()['AuthorUid'],
                    bookmarkedBy: e.data()['BookmarkedBy'],
                    country: e.data()['Country'],
                    documentId: e.data()['DocumentId'],
                    galleryImages: e.data()['GalleryImages'],
                    isArticlePublished: await e.data()['IsArticlePublished'],
                    isArticleReported: e.data()['IsArticleReported'],
                    noOfComments: e.data()['NoOfComments'],
                    noOfViews: e.data()['NoOfViews'],
                    noOflikes: e.data()['NoOfLikes'],
                    shortDescription: e.data()['ShortDescription'],
                    socialMediaLink: e.data()['SocialMedialink']));
                emit(state.copyWith(articledata));
              }
            });
          });
        } else {
          print("subtype 3");
          HiveArticlesTitlePreferences().storeArticleName(pref, null);
          articleDataBox.clear();

          FirebaseFirestore.instance
              .collection('NewArticleCollection')
              //    .where("IsArticlePublished", isEqualTo: "Published")
              .orderBy('CreatedTime', descending: true)
              .get()
              .then((value) async {
            value.docs.forEach((e) async {
              if (articleList.contains(e.data()['ArticleTitle'])) {
              } else {
                dummyArticleList.add(await e.data()['ArticleTitle']);
                HiveArticlesTitlePreferences()
                    .storeArticleName(pref, dummyArticleList);

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
                  ..socialMediaLink = await e.data()['SocialMedialink']
                  ..shortDescription = await e.data()['ShortDescription'];

                final box = Boxes.getArticleFromCloud();

                box.add(data);

                articledata.add(CodeArticleData(
                    articleDescription: e.data()['ArticleDescription'],
                    articleLike: e.data()['ArticleLike'],
                    articlePhotoUrl: await e.data()['ArticlePhotoUrl'],
                    articleReportedBy: await e.data()['ArticleReportedBy'],
                    articleSubtype: e.data()['ArticleSubtype'],
                    articleTitle: e.data()['ArticleTitle'],
                    authorName: e.data()['AuthorName'],
                    authorUid: e.data()['AuthorUid'],
                    bookmarkedBy: e.data()['BookmarkedBy'],
                    country: e.data()['Country'],
                    documentId: e.data()['DocumentId'],
                    galleryImages: e.data()['GalleryImages'],
                    isArticlePublished: await e.data()['IsArticlePublished'],
                    isArticleReported: e.data()['IsArticleReported'],
                    noOfComments: e.data()['NoOfComments'],
                    noOfViews: e.data()['NoOfViews'],
                    noOflikes: e.data()['NoOfLikes'],
                    shortDescription: e.data()['ShortDescription'],
                    socialMediaLink: e.data()['SocialMedialink']));
                emit(state.copyWith(articledata));
              }
            });
          });
        }
      } else {
        print("subtype 4");
        HiveArticlesTitlePreferences().storeArticleName(pref, null);
        articleDataBox.clear();

        FirebaseFirestore.instance
            .collection('NewArticleCollection')
            //  .where("IsArticlePublished", isEqualTo: "Published")
            .orderBy('CreatedTime', descending: true)
            .get()
            .then((value) async {
          value.docs.forEach((e) async {
            dummyArticleList.add(await e.data()['ArticleTitle'].toString());
            HiveArticlesTitlePreferences()
                .storeArticleName(pref, dummyArticleList);
            print("data initial $dummyArticleList");

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
              ..socialMediaLink = await e.data()['SocialMedialink']
              ..shortDescription = await e.data()['ShortDescription'];

            print(data);

            final box = Boxes.getArticleFromCloud();

            box.add(data);

            articledata.add(CodeArticleData(
                articleDescription: e.data()['ArticleDescription'],
                articleLike: e.data()['ArticleLike'],
                articlePhotoUrl: await e.data()['ArticlePhotoUrl'],
                articleReportedBy: await e.data()['ArticleReportedBy'],
                articleSubtype: e.data()['ArticleSubtype'],
                articleTitle: e.data()['ArticleTitle'],
                authorName: e.data()['AuthorName'],
                authorUid: e.data()['AuthorUid'],
                bookmarkedBy: e.data()['BookmarkedBy'],
                country: e.data()['Country'],
                documentId: e.data()['DocumentId'],
                galleryImages: e.data()['GalleryImages'],
                isArticlePublished: await e.data()['IsArticlePublished'],
                isArticleReported: e.data()['IsArticleReported'],
                noOfComments: e.data()['NoOfComments'],
                noOfViews: e.data()['NoOfViews'],
                noOflikes: e.data()['NoOfLikes'],
                shortDescription: e.data()['ShortDescription'],
                socialMediaLink: e.data()['SocialMedialink']));
            emit(state.copyWith(articledata));
          });
        });
      }
    });
  }
}
