import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../HiveArticlesModel/LocalArticleModel/code_article_model.dart';
import '../../NewHomePage/Components/home_page_center_pane_article_card.dart';
import '../../utils/routes.dart';
import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_body_right_pane.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_footer.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_header.dart';
import '/Journz_Large_Screen/NewHomePage/Components/left_pane_profile.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';

class ShowrejectedArticles extends StatefulWidget {
  const ShowrejectedArticles({Key? key}) : super(key: key);

  @override
  _ShowrejectedArticlesState createState() => _ShowrejectedArticlesState();
}

class _ShowrejectedArticlesState extends State<ShowrejectedArticles> {
  List<HiveArticleData> personalArticles = [];
  @override
  Widget build(BuildContext context) {
    final userState = BlocProvider.of<CheckuserloginedCubit>(context);
    userState.checkLogin();
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePageHeader(wantSearchBar: true, fromMobile: false),
            SizedBox(height: context.screenHeight * 0.015),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeftPaneProfile(),
                    Container(
                      //  color: Colors.red,
                      width: context.screenWidth * 0.55,
                      height: context.screenHeight * 0.9,
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black.withOpacity(0.3),
                                  width: 2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 8,
                            child: "Articles Rejected"
                                .text
                                .xl2
                                .bold
                                .make()
                                .box
                                .alignCenterLeft
                                .px20
                                .width(context.screenWidth * 0.8)
                                .height(context.screenHeight * 0.07)
                                .make(),
                          ),
                          SizedBox(height: context.screenHeight * 0.03),
                          BlocBuilder<CheckuserloginedCubit,
                              CheckuserloginedState>(
                            builder: (context, loginState) {
                              return loginState.isLoggined!
                                  ? Container(
                                      child: ValueListenableBuilder<
                                              Box<HiveArticleData>>(
                                          valueListenable:
                                              Boxes.getArticleFromCloud()
                                                  .listenable(),
                                          builder: (context, value, _) {
                                            value.values.forEach((element) {
                                              if (element.authorUid ==
                                                      loginState.userUid &&
                                                  element.isArticlePublished ==
                                                      "Rejected") {
                                                personalArticles.add(element);
                                              }
                                            });
                                            return personalArticles.isNotEmpty
                                                ? ListView.separated(
                                                    separatorBuilder: (context,
                                                            index) =>
                                                        SizedBox(height: 20),
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        personalArticles.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        margin: EdgeInsets.only(
                                                            left: index.isOdd
                                                                ? context
                                                                        .screenWidth *
                                                                    0.08
                                                                : 0,
                                                            right: index.isEven
                                                                ? context
                                                                        .screenWidth *
                                                                    0.08
                                                                : 0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            // ignore: unused_local_variable
                                                            CodeArticleData data = CodeArticleData(
                                                                articleDescription:
                                                                    personalArticles[index]
                                                                        .articleDescription,
                                                                articleLike: personalArticles[index]
                                                                    .articleLike,
                                                                articlePhotoUrl:
                                                                    personalArticles[index]
                                                                        .articlePhotoUrl,
                                                                articleReportedBy:
                                                                    personalArticles[index]
                                                                        .articleReportedBy,
                                                                articleSubtype:
                                                                    personalArticles[index]
                                                                        .articleSubtype,
                                                                articleTitle:
                                                                    personalArticles[index]
                                                                        .articleTitle,
                                                                authorName: personalArticles[index]
                                                                    .authorName,
                                                                authorUid: personalArticles[index]
                                                                    .authorUid,
                                                                bookmarkedBy:
                                                                    personalArticles[index]
                                                                        .bookmarkedBy,
                                                                country: personalArticles[index]
                                                                    .country,
                                                                documentId: personalArticles[index]
                                                                    .documentId,
                                                                galleryImages:
                                                                    personalArticles[index]
                                                                        .galleryImages,
                                                                isArticlePublished:
                                                                    personalArticles[index].isArticlePublished,
                                                                isArticleReported: personalArticles[index].isArticleReported,
                                                                noOfComments: personalArticles[index].noOfComments,
                                                                noOfViews: personalArticles[index].noOfViews,
                                                                noOflikes: personalArticles[index].noOflikes,
                                                                socialMediaLink: personalArticles[index].socialMediaLink);

                                                            context.vxNav.push(
                                                                Uri(
                                                                    path: MyRoutes
                                                                        .homeRoute,
                                                                    queryParameters: {
                                                                      "Page":
                                                                          "/Articles",
                                                                      "id": personalArticles[
                                                                              index]
                                                                          .documentId
                                                                    }),
                                                                params:
                                                                    personalArticles[
                                                                        index]);
                                                          },
                                                          child: HomePageCenterPaneArticleCard(
                                                              index: index,
                                                              listOfArticles: CodeArticleData(
                                                                  articleDescription:
                                                                      personalArticles[index]
                                                                          .articleDescription,
                                                                  articleLike:
                                                                      personalArticles[index]
                                                                          .articleLike,
                                                                  articlePhotoUrl:
                                                                      personalArticles[index]
                                                                          .articlePhotoUrl,
                                                                  articleReportedBy:
                                                                      personalArticles[index]
                                                                          .articleReportedBy,
                                                                  articleSubtype:
                                                                      personalArticles[index]
                                                                          .articleSubtype,
                                                                  articleTitle:
                                                                      personalArticles[index]
                                                                          .articleTitle,
                                                                  authorName: personalArticles[index]
                                                                      .authorName,
                                                                  authorUid: personalArticles[index]
                                                                      .authorUid,
                                                                  bookmarkedBy:
                                                                      personalArticles[index]
                                                                          .bookmarkedBy,
                                                                  country: personalArticles[index]
                                                                      .country,
                                                                  documentId: personalArticles[index]
                                                                      .documentId,
                                                                  galleryImages:
                                                                      personalArticles[index]
                                                                          .galleryImages,
                                                                  isArticlePublished:
                                                                      personalArticles[index].isArticlePublished,
                                                                  isArticleReported: personalArticles[index].isArticleReported,
                                                                  noOfComments: personalArticles[index].noOfComments,
                                                                  noOfViews: personalArticles[index].noOfViews,
                                                                  noOflikes: personalArticles[index].noOflikes,
                                                                  socialMediaLink: personalArticles[index].socialMediaLink)),
                                                        ),
                                                      ) /*) */;
                                                    },
                                                  )
                                                    .box
                                                    .width(context.screenWidth *
                                                        0.55)
                                                    .height(
                                                        context.screenHeight *
                                                            0.78)
                                                    .make()
                                                : Center(
                                                    child: Text(
                                                        "You Dont Have Articles"),
                                                  );
                                          }),
                                    )
                                  : Center(
                                      child: Text(
                                          'Please Login Into Your Account'),
                                    );
                            },
                          )
                        ],
                      ),
                    ),
                    BodyRightPane(
                      isHome: false,
                      favouriteCategory: swapToFavouriteArticles,
                    )
                  ],
                ),
                HomePageFooter()
              ],
            )
                .scrollVertical()
                .box
                .width(context.screenWidth)
                .height(context.screenHeight * 0.9)
                .make()
          ],
        ),
      ),
    );
  }

  swapToFavouriteArticles(String screen) {
    context
        .read<ShowCurrentlySelectedSubtypeCubit>()
        .changeSelectedSubtypeTo(screen);
  }
}
