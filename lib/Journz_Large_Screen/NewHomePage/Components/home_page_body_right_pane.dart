import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import '/Journz_Large_Screen/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class BodyRightPane extends StatefulWidget {
  final Function(String) favouriteCategory;
  final bool isHome;
  const BodyRightPane(
      {Key? key, required this.isHome, required this.favouriteCategory})
      : super(key: key);

  @override
  _BodyRightPaneState createState() => _BodyRightPaneState();
}

class _BodyRightPaneState extends State<BodyRightPane> {
  List<HiveArticleData> listOfArticles = [];
  List<HiveArticleData> listOfArticles2 = [];
  List<HiveArticleData> listOfArticles3 = [];
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'baln2rRKyJ0',
    params: YoutubePlayerParams(
      startAt: Duration.zero,
      mute: true,
      autoPlay: true,
      loop: true,
      strictRelatedVideos: true,
      showControls: false,
      showFullscreenButton: false,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: context.screenWidth * 0.02),
      width: context.screenWidth * 0.225,
      //height: context.screenWidth * 0.9,
      //color: Colors.blue.shade50,
      child: BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
          builder: (context, state) {
        return Column(
          children: [
            !state.isLoggined!
                ? Text('Create Account To Have Personalized Favourite Categories. \n\nClick Sign Up Button Above')
                    .text
                    .xl
                    .make()
                    .box
                    .p20
                    .alignCenter
                    .blue200
                    .width(context.screenWidth * 0.2)
                    .height(context.screenWidth * 0.15)
                    .make()
                : Container(),
            Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 2)),
                    child: Column(children: [
                      state.isLoggined!
                          ? Text('Favourite Categories')
                              .text
                              .xl
                              .semiBold
                              .align(TextAlign.start)
                              .make()
                              .box
                              .p12
                              .alignCenterLeft
                              .make()
                          : Container(),
                      BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
                        builder: (context, userState) {
                          return userState.isLoggined!
                              ? userState.favCategories!.isNotEmpty
                                  ? GridView.builder(
                                      itemCount:
                                          userState.favCategories!.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 3,
                                              crossAxisSpacing: 4,
                                              mainAxisSpacing: 4,
                                              crossAxisCount: 2),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            if (widget.isHome) {
                                              widget.favouriteCategory(userState
                                                  .favCategories![index]);
                                            } else {
                                              context.vxNav.push(
                                                  Uri(path: MyRoutes.homeRoute),
                                                  params: userState
                                                      .favCategories![index]
                                                      .toString());
                                            }

                                            /* if (widget.screen == "Article") {
                                              Navigator.of(context).pop();
                                              context.vxNav.pop();
                                              context
                                                  .read<
                                                      ShowCurrentlySelectedSubtypeCubit>()
                                                  .changeSelectedSubtypeTo(
                                                      userState.favCategories![
                                                          index]);
                                            } else {
                                              context
                                                  .read<
                                                      ShowCurrentlySelectedSubtypeCubit>()
                                                  .changeSelectedSubtypeTo(
                                                      userState.favCategories![
                                                          index]);
                                            } */
                                          },
                                          child: Text(userState
                                                  .favCategories![index])
                                              .text
                                              .semiBold
                                              .make()
                                              .box
                                              .p8
                                              .gray200
                                              .alignCenter
                                              .customRounded(
                                                  BorderRadius.circular(10))
                                              .width(context.screenWidth * 0.09)
                                              .height(
                                                  context.screenWidth * 0.01)
                                              .make(),
                                        );
                                      },
                                    )
                                      .box
                                      .width(context.screenWidth * 0.2)
                                      .height(context.screenWidth * 0.1)
                                      .make()
                                  : Center(
                                          child:
                                              "Double Tap on the categories to Add it in Favourite List"
                                                  .text
                                                  .semiBold
                                                  .xl
                                                  .make())
                                      .box
                                      .width(context.screenWidth * 0.2)
                                      .height(context.screenWidth * 0.1)
                                      .make()
                              : Container();
                        },
                      ),
                    ]))
                .box
                .customRounded(BorderRadius.circular(10))
                // .withDecoration(BoxDecoration(
                //   border: Border.all(width: 5, color: Colors.black)))
                .neumorphic(color: Colors.white, elevation: 8)
                .make(),
            SizedBox(height: context.screenWidth * 0.01),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Color.fromARGB(255, 255, 255, 255), width: 2)),
                child: Column(children: [
                  "Advertisement"
                      .text
                      .xl
                      .semiBold
                      .make()
                      .box
                      .px12
                      .alignCenterLeft
                      .make(),
                  Container(
                    width: context.screenWidth * 0.2,
                    height: context.screenWidth * 0.125,
                    child: YoutubePlayerControllerProvider(
                      // Provides controller to all the widget below it.
                      controller: _controller,
                      child: YoutubePlayerIFrame(),
                    ),
                  )
                ])),
            SizedBox(height: context.screenWidth * 0.01),
            Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 2)),
                    child: Column(children: [
                      "Popular Articles"
                          .text
                          .xl
                          .semiBold
                          .make()
                          .box
                          .px12
                          .alignCenterLeft
                          .make(),
                      Container(
                        width: context.screenWidth * 0.2,
                        height: context.screenWidth * 0.125,
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.topLeft,
                        child: ValueListenableBuilder<Box<HiveArticleData>>(
                            valueListenable:
                                Boxes.getArticleFromCloud().listenable(),
                            builder: (context, value, _) {
                              listOfArticles2 =
                                  value.values.toList().cast<HiveArticleData>();
                              listOfArticles = listOfArticles2.sortedBy(
                                  (b, a) => a.noOfViews.compareTo(b.noOfViews));

                              return listOfArticles.isNotEmpty
                                  ? CarouselSlider.builder(
                                      itemCount: listOfArticles.length,
                                      itemBuilder: (context, index, realIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            context.vxNav.push(
                                                Uri(
                                                    path: MyRoutes.homeRoute,
                                                    queryParameters: {
                                                      "Page": "/Articles",
                                                      "id":
                                                          listOfArticles[index]
                                                              .documentId
                                                    }),
                                                params: listOfArticles[index]);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            color: Colors.grey.shade200,
                                            child: Column(
                                              children: [
                                                /* listOfArticles[index].articlePhotoUrl !=
                                              "WithoutImage"
                                          ? Image.network(listOfArticles[index]
                                                  .articlePhotoUrl)
                                              .box
                                              .width(context.screenWidth)
                                              .alignCenterLeft
                                              .height(
                                                  context.screenWidth * 0.125)
                                              .make()
                                          : Container(), */
                                                Text(listOfArticles[index]
                                                        .articleTitle!)
                                                    .text
                                                    .semiBold
                                                    .maxLines(2)
                                                    .align(TextAlign.left)
                                                    .overflow(
                                                        TextOverflow.ellipsis)
                                                    .make()
                                                    .box
                                                    .alignCenterLeft
                                                    .make(),
                                                Html(
                                                        data: listOfArticles[
                                                                index]
                                                            .articleDescription)
                                                    /*  .text
                                          .semiBold
                                          .maxLines(2)
                                          .align(TextAlign.left)
                                          .overflow(TextOverflow.ellipsis)
                                          .make() */
                                                    .box
                                                    .width(context.screenWidth *
                                                        0.225)
                                                    .height(
                                                        context.screenWidth *
                                                            0.065)
                                                    .alignCenterLeft
                                                    .make(),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                          enlargeCenterPage: true))
                                  : Container();
                            }),
                      )
                    ]))
                .box
                .customRounded(BorderRadius.circular(10))
                // .withDecoration(BoxDecoration(
                //   border: Border.all(width: 5, color: Colors.black)))
                .neumorphic(color: Colors.white, elevation: 8)
                .make(),
          ],
        );
      }),
    );
  }
}
