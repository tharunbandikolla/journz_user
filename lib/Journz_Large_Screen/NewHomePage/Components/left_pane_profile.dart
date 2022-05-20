import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/Journz_Large_Screen/Common/Data/author_request_terms.dart';
import '/Journz_Large_Screen/HiveArticlesModel/LocalArticleModel/code_article_model.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/check_favourite_categories_cubit/check_favourite_categories_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/leftpane_expansiontile_cubit/leftpane_expansion_tile_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/notification_on_off_cubit/notificationonoff_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveArticleSubtypeModel/hive_article_subtype_model.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import '/Journz_Large_Screen/utils/routes.dart';

import 'package:velocity_x/velocity_x.dart';

class LeftPaneProfile extends StatefulWidget {
  const LeftPaneProfile({Key? key}) : super(key: key);

  @override
  _LeftPaneProfileState createState() => _LeftPaneProfileState();
}

class _LeftPaneProfileState extends State<LeftPaneProfile> {
  List<String> listOfSubtype = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
      builder: (context, userState) {
        if (userState.isLoggined!) {
          context
              .read<NotificationonoffCubit>()
              .toggleNotification(userState.userUid ?? "n");
        }
        return BlocBuilder<LeftpaneExpansionTileCubit,
            LeftpaneExpansionTileState>(builder: (context, expansionState) {
          return Container(
            width: context.screenWidth * 0.175,
            child: Stack(
              children: [
                Positioned(
                  top: context.screenHeight * 0.0875,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      if (userState.isLoggined!) {
                        context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeRoute,
                              queryParameters: {"Page": "/UserProfile"}),
                        );
                      }
                    },
                    child: Container(
                      width: context.screenWidth * 0.175,
                      height: context.screenHeight * 0.21,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.screenHeight * 0.095),
                          (userState.name ?? "Hii Journz")
                              .text
                              .align(TextAlign.justify)
                              .semiBold
                              .xl
                              .make()
                              .box
                              .alignCenter
                              .make(),
                          SizedBox(height: context.screenHeight * 0.01),
                          (userState.country ?? "")
                              .text
                              .align(TextAlign.justify)
                              .semiBold
                              .make()
                              .box
                              .alignCenter
                              .make()
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: context.screenHeight * 0.2975,
                    left: 0,
                    child: Container(
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () {
                                context
                                    .read<LeftpaneExpansionTileCubit>()
                                    .whatSection("Articles");
                                context.vxNav.popToRoot();
                              },
                              child: "Articles"
                                  .text
                                  .xl2
                                  .white
                                  .semiBold
                                  .make()
                                  .box
                                  .width(context.screenWidth * 0.175)
                                  .height(context.screenHeight * 0.075)
                                  .p12
                                  .alignCenter
                                  .blue400
                                  .make()),
                          AnimatedContainer(
                              height: userState.isLoggined!
                                  ? expansionState.expandablePane == "Articles"
                                      ? userState.role == "ContentWriter"
                                          ? context.screenHeight * 0.45
                                          : context.screenHeight * 0.225
                                      : 0
                                  : 0,
                              width: context.screenWidth * 0.175,
                              duration: Duration(milliseconds: 300),
                              child: Column(children: [
                                userState.isLoggined!
                                    ? InkWell(
                                        onTap: () {
                                          showFavouriteCategoriesDialog(
                                              userState);
                                        },
                                        child: "Favourite Categories"
                                            .text
                                            .xl
                                            .semiBold
                                            .make()
                                            .box
                                            .color(Colors.grey.shade200)
                                            .width(context.screenWidth * 0.175)
                                            .height(
                                                context.screenHeight * 0.075)
                                            .p12
                                            .alignCenter
                                            .make(),
                                      )
                                    : Container(),
                                userState.isLoggined!
                                    ? userState.role! == "ContentWriter"
                                        ? InkWell(
                                            onTap: () {
                                              context.vxNav.push(
                                                  Uri(
                                                      path: MyRoutes.homeRoute,
                                                      queryParameters: {
                                                        "Page": "/CreateArticle"
                                                      }),
                                                  params: {
                                                    'isEditArticle': false,
                                                    "articleData":
                                                        CodeArticleData()
                                                  });
                                            },
                                            child: "Create Article"
                                                .text
                                                .xl
                                                .semiBold
                                                .make()
                                                .box
                                                .color(Colors.grey.shade200)
                                                .width(
                                                    context.screenWidth * 0.175)
                                                .height(context.screenHeight *
                                                    0.075)
                                                .p12
                                                .alignCenter
                                                .make(),
                                          )
                                        : Container()
                                    : Container(),
                                userState.isLoggined!
                                    ? InkWell(
                                        onTap: () {
                                          context.vxNav.push(
                                            Uri(
                                                path: MyRoutes.homeRoute,
                                                queryParameters: {
                                                  "Page": "/PersonalArticles"
                                                }),
                                          );
                                        },
                                        child: "Published Article"
                                            .text
                                            .xl
                                            .semiBold
                                            .make()
                                            .box
                                            .color(Colors.grey.shade200)
                                            .width(context.screenWidth * 0.175)
                                            .height(
                                                context.screenHeight * 0.075)
                                            .p12
                                            .alignCenter
                                            .make(),
                                      )
                                    : Container(),
                                userState.isLoggined!
                                    ? InkWell(
                                        onTap: () {
                                          context.vxNav.push(
                                            Uri(
                                                path: MyRoutes.homeRoute,
                                                queryParameters: {
                                                  "Page": "/ArticlesUnderReview"
                                                }),
                                          );
                                        },
                                        child: "Article Under Review"
                                            .text
                                            .xl
                                            .semiBold
                                            .make()
                                            .box
                                            .color(Colors.grey.shade200)
                                            .width(context.screenWidth * 0.175)
                                            .height(
                                                context.screenHeight * 0.075)
                                            .p12
                                            .alignCenter
                                            .make(),
                                      )
                                    : Container(),
                                userState.isLoggined!
                                    ? InkWell(
                                        onTap: () {
                                          context.vxNav.push(
                                            Uri(
                                                path: MyRoutes.homeRoute,
                                                queryParameters: {
                                                  "Page": "/RejectedArticles"
                                                }),
                                          );
                                        },
                                        child: "Rejected Article"
                                            .text
                                            .xl
                                            .semiBold
                                            .make()
                                            .box
                                            .color(Colors.grey.shade200)
                                            .width(context.screenWidth * 0.175)
                                            .height(
                                                context.screenHeight * 0.075)
                                            .p12
                                            .alignCenter
                                            .make(),
                                      )
                                    : Container(),
                                userState.isLoggined!
                                    ? InkWell(
                                        onTap: () {
                                          context.vxNav.push(
                                            Uri(
                                                path: MyRoutes.homeRoute,
                                                queryParameters: {
                                                  "Page": "/SavedArticles"
                                                }),
                                          );
                                        },
                                        child: "Saved Article"
                                            .text
                                            .xl
                                            .semiBold
                                            .make()
                                            .box
                                            .color(Colors.grey.shade200)
                                            .width(context.screenWidth * 0.175)
                                            .height(
                                                context.screenHeight * 0.075)
                                            .p12
                                            .alignCenter
                                            .make(),
                                      )
                                    : Container(),
                              ])),
                          SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              context
                                  .read<LeftpaneExpansionTileCubit>()
                                  .whatSection("News");
                            },
                            child: "Newz"
                                .text
                                .xl2
                                .white
                                .semiBold
                                .make()
                                .box
                                .width(context.screenWidth * 0.175)
                                .height(context.screenHeight * 0.075)
                                .p12
                                .alignCenter
                                .blue400
                                .make(),
                          ),
                          AnimatedContainer(
                            width: context.screenWidth * 0.175,
                            height: userState.isLoggined!
                                ? expansionState.expandablePane == "News"
                                    ? context.screenHeight * 0.3
                                    : 0
                                : 0,
                            duration: Duration(milliseconds: 300),
                            child: Column(children: [
                              userState.isLoggined!
                                  ? InkWell(
                                      onTap: () {},
                                      child: "Favourite News"
                                          .text
                                          .xl
                                          .semiBold
                                          .make()
                                          .box
                                          .color(Colors.grey.shade200)
                                          .width(context.screenWidth * 0.175)
                                          .height(context.screenHeight * 0.075)
                                          .p12
                                          .alignCenter
                                          .make(),
                                    )
                                  : Container(),
                              userState.isLoggined!
                                  ? userState.role! == "ContentWriter"
                                      ? InkWell(
                                          onTap: () {},
                                          child: "Create News"
                                              .text
                                              .xl
                                              .semiBold
                                              .make()
                                              .box
                                              .color(Colors.grey.shade200)
                                              .width(
                                                  context.screenWidth * 0.175)
                                              .height(
                                                  context.screenHeight * 0.075)
                                              .p12
                                              .alignCenter
                                              .make(),
                                        )
                                      : Container()
                                  : Container(),
                              userState.isLoggined!
                                  ? InkWell(
                                      onTap: () {},
                                      child: "Published News"
                                          .text
                                          .xl
                                          .semiBold
                                          .make()
                                          .box
                                          .color(Colors.grey.shade200)
                                          .width(context.screenWidth * 0.175)
                                          .height(context.screenHeight * 0.075)
                                          .p12
                                          .alignCenter
                                          .make(),
                                    )
                                  : Container(),
                              userState.isLoggined!
                                  ? InkWell(
                                      onTap: () {},
                                      child: "Saved News"
                                          .text
                                          .xl
                                          .semiBold
                                          .make()
                                          .box
                                          .color(Colors.grey.shade200)
                                          .width(context.screenWidth * 0.175)
                                          .height(context.screenHeight * 0.075)
                                          .p12
                                          .alignCenter
                                          .make(),
                                    )
                                  : Container(),
                            ]),
                          ),
                          SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              context
                                  .read<LeftpaneExpansionTileCubit>()
                                  .whatSection("Settings");
                            },
                            child: "Settings"
                                .text
                                .xl2
                                .white
                                .semiBold
                                .make()
                                .box
                                .width(context.screenWidth * 0.175)
                                .height(context.screenHeight * 0.075)
                                .p12
                                .alignCenter
                                .blue400
                                .make(),
                          ),
                          AnimatedContainer(
                            width: context.screenWidth * 0.175,
                            height: userState.isLoggined!
                                ? expansionState.expandablePane == "Settings"
                                    ? context.screenHeight * 0.3
                                    : 0
                                : 0,
                            duration: Duration(milliseconds: 300),
                            child: Column(children: [
                              userState.isLoggined!
                                  ? InkWell(
                                      onTap: () {
                                        if (userState.isLoggined!) {
                                          context.vxNav.push(
                                            Uri(
                                                path: MyRoutes.homeRoute,
                                                queryParameters: {
                                                  "Page": "/UserProfile"
                                                }),
                                          );
                                        }
                                      },
                                      child: "Profile"
                                          .text
                                          .xl
                                          .semiBold
                                          .make()
                                          .box
                                          .color(Colors.grey.shade200)
                                          .width(context.screenWidth * 0.175)
                                          .height(context.screenHeight * 0.075)
                                          .p12
                                          .alignCenter
                                          .make())
                                  : Container(),
                              userState.isLoggined!
                                  ? userState.role == "User"
                                      ? InkWell(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('UserProfile')
                                                .doc(userState.userUid)
                                                .get()
                                                .then((value) {
                                              if (value.data()![
                                                      'RequestAuthor'] ==
                                                  "False") {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Terms & Condition"),
                                                        content:
                                                            Text(authorTerms),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'Close')),
                                                          TextButton(
                                                              onPressed: () {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'UserProfile')
                                                                    .doc(userState
                                                                        .userUid)
                                                                    .update({
                                                                  "RequestAuthor":
                                                                      "True"
                                                                }).then((value) =>
                                                                        Navigator.pop(
                                                                            context));
                                                              },
                                                              child: Text(
                                                                  'Accept'))
                                                        ],
                                                      );
                                                    });
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "We Have Received You Request, We Will Process It Soon"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Close'))
                                                        ],
                                                      );
                                                    });
                                              }
                                            });
                                          },
                                          child: "Request Author Role"
                                              .text
                                              .xl
                                              .semiBold
                                              .make()
                                              .box
                                              .color(Colors.grey.shade200)
                                              .width(
                                                  context.screenWidth * 0.175)
                                              .height(
                                                  context.screenHeight * 0.075)
                                              .p12
                                              .alignCenter
                                              .make())
                                      : Container()
                                  : Container(),
                              BlocBuilder<NotificationonoffCubit,
                                  NotificationonoffState>(
                                builder: (context, notificationState) {
                                  return InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return BlocProvider(
                                                  create: (context) =>
                                                      NotificationonoffCubit(),
                                                  child: BlocBuilder<
                                                      NotificationonoffCubit,
                                                      NotificationonoffState>(
                                                    builder: (context,
                                                        notificationState) {
                                                      context
                                                          .read<
                                                              NotificationonoffCubit>()
                                                          .toggleNotification(
                                                              userState
                                                                  .userUid!);
                                                      return AlertDialog(
                                                        title: Text("Alert..!"),
                                                        content: Text(
                                                            "Are You Sure You want to ${notificationState.notificationState}.?"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text("No")),
                                                          TextButton(
                                                              onPressed: () {
                                                                if (notificationState
                                                                        .notificationState ==
                                                                    "Disable Notification") {
                                                                  updateWebNotificationToken(
                                                                      userState
                                                                          .userUid!,
                                                                      false);
                                                                  Navigator.pop(
                                                                      context);
                                                                } else {
                                                                  /* FirebaseMessaging
                                                                      .instance
                                                                      .getToken(
                                                                          vapidKey:
                                                                              "BOuQ9ODWQnHDc4ObmZHYEZ9dIjKcszc2EpRVv6e8sAGs4t05tfBpilhPatLnwmqHMa4Pn5UnjIy978P_fHu3kvM")
                                                                      .then(
                                                                          (token) {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "UserProfile")
                                                                        .doc(userState
                                                                            .userUid!)
                                                                        .update({
                                                                      "WebNotificationToken":
                                                                          token
                                                                    }); */
                                                                  /*  FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "GeneralAppUserNotification")
                                                                        .doc(userState
                                                                            .userUid!)
                                                                        .update({
                                                                      "NotificationToken":
                                                                          token
                                                                    }); */
                                                                  /* FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "GeneralWebUserNotification")
                                                                        .doc(userState
                                                                            .userUid!)
                                                                        .update({
                                                                      "WebNotificationToken":
                                                                          token
                                                                    }); */
                                                                  updateWebNotificationToken(
                                                                      userState
                                                                          .userUid!,
                                                                      true);
                                                                  Navigator.pop(
                                                                      context);
                                                                  /* }); */
                                                                }
                                                              },
                                                              child:
                                                                  Text("Yes"))
                                                        ],
                                                      );
                                                    },
                                                  ));
                                            });
                                      },
                                      child: notificationState
                                          .notificationState.text.xl.semiBold
                                          .make()
                                          .box
                                          .color(Colors.grey.shade200)
                                          .width(context.screenWidth * 0.175)
                                          .height(context.screenHeight * 0.075)
                                          .p12
                                          .alignCenter
                                          .make());
                                },
                              ), /* 
                              ElevatedButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("NewArticleCollection")
                                        .get()
                                        .then((value) {
                                      value.docs.forEach((element) {
                                        FirebaseFirestore.instance
                                            .collection("NewArticleCollection")
                                            .doc(element.id)
                                            .update({
                                          "ShortDescription":
                                              "Short Description"
                                        });
                                      });
                                    });
                                  },
                                  child: Text("update")) */
                            ]),
                          ),
                        ],
                      ),
                    )),
                Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: () {
                        if (userState.isLoggined!) {
                          context.vxNav.push(
                            Uri(
                                path: MyRoutes.homeRoute,
                                queryParameters: {"Page": "/UserProfile"}),
                          );
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: context.screenWidth * 0.25,
                            height: context.screenHeight * 0.175,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade100),
                          ),
                          Container(
                            width: context.screenWidth * 0.2,
                            height: context.screenHeight * 0.15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade200),
                          ),
                          Container(
                            width: context.screenWidth * 0.185,
                            height: context.screenHeight * 0.13,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade300),
                          ),
                          userState.isLoggined!
                              ? userState.photoUrl == "images/fluenzologo.png"
                                  ? CircleAvatar(
                                      radius: 38.0,
                                      backgroundImage:
                                          AssetImage('assets/images/logo.png'),
                                      backgroundColor: Colors.transparent,
                                    )
                                  : CircleAvatar(
                                      radius: 38.0,
                                      backgroundImage:
                                          NetworkImage(userState.photoUrl!),
                                      backgroundColor: Colors.transparent,
                                    )
                              : CircleAvatar(
                                  radius: 38.0,
                                  backgroundImage:
                                      AssetImage('assets/images/logo.png'),
                                  backgroundColor: Colors.transparent,
                                )
                        ],
                      ),
                    ))
              ],
            )
                .box
                .width(context.screenWidth * 0.175)
                .height(context.screenHeight)
                .make(),
          );
        });
      },
    );
  }

  void showFavouriteCategoriesDialog(CheckuserloginedState userState) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BlocProvider(
            create: (context) => CheckFavouriteCategoriesCubit(
                initialData: userState.favCategories!),
            child: BlocBuilder<CheckFavouriteCategoriesCubit,
                CheckFavouriteCategoriesState>(
              builder: (context, checkFavstate) {
                return Dialog(
                  child: Container(
                    width: context.screenWidth * 0.35,
                    height: context.screenHeight * 0.65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        "Select Favourite Categories"
                            .text
                            .xl
                            .semiBold
                            .make()
                            .box
                            .alignCenterLeft
                            .p12
                            .make(),
                        ValueListenableBuilder<Box<HiveArticlesSubtypes>>(
                          valueListenable:
                              Boxes.getArticleSubtypeFromCloud().listenable(),
                          builder: (context, value, _) {
                            var subtype = value.values
                                .toList()
                                .cast<HiveArticlesSubtypes>();

                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: subtype.length,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    context
                                        .read<CheckFavouriteCategoriesCubit>()
                                        .addOrRemoveCategories(
                                            checkFavstate.selectedCategories,
                                            subtype[index].subtypeName);
                                  },
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              maxRadius:
                                                  context.screenHeight * 0.065,
                                              backgroundImage: NetworkImage(
                                                  subtype[index].photoUrl),
                                            ),
                                            Text(subtype[index].subtypeName)
                                                .text
                                                .make(),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: checkFavstate
                                                  .selectedCategories
                                                  .contains(subtype[index]
                                                      .subtypeName)
                                              ? Icon(Icons.check)
                                              : Container(),
                                        ),
                                      ]),
                                );
                              },
                            )
                                .box
                                .width(context.screenWidth * 0.3)
                                .height(context.screenHeight * 0.47)
                                .make();
                          },
                        ),
                        ElevatedButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('UserProfile')
                                  .doc(userState.userUid)
                                  .update({
                                'UsersFavouriteArticleCategory':
                                    checkFavstate.selectedCategories
                              }).whenComplete(() => Navigator.pop(context));
                            },
                            child: Text('Done'))
                      ],
                    ),
                  ),
                );
              },
            ));
        ;
      },
    );
  }

  updateWebNotificationToken(String userUid, bool enable) {
    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                "BOuQ9ODWQnHDc4ObmZHYEZ9dIjKcszc2EpRVv6e8sAGs4t05tfBpilhPatLnwmqHMa4Pn5UnjIy978P_fHu3kvM")
        .then((token) async {
      print("device type $kIsWeb");
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String? deviceIdentifier;

      if (kIsWeb) {
        WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
        deviceIdentifier =
            "${webInfo.vendor!}${webInfo.userAgent!}${webInfo.hardwareConcurrency}";

        print(
            "device identifier ${deviceIdentifier.replaceAll("/", "").replaceAll(" ", "")}");
        if (enable) {
          FirebaseFirestore.instance
              .collection("PublicNotification")
              .where("NotificationToken",
                  isEqualTo:
                      deviceIdentifier.replaceAll("/", "").replaceAll(" ", ""))
              .get()
              .then((value) {
            if (value.size == 0) {
              FirebaseFirestore.instance
                  .collection("PublicNotification")
                  .doc(
                      deviceIdentifier!.replaceAll("/", "").replaceAll(" ", ""))
                  .set({"NotificationToken": token});
            }
          });
          FirebaseFirestore.instance
              .collection("UserProfile")
              .doc(userUid)
              .update({"WebNotificationToken": token});
        } else {
          FirebaseFirestore.instance
              .collection("UserProfile")
              .doc(userUid)
              .update({"WebNotificationToken": "Disable Notification"});

          FirebaseFirestore.instance
              .collection("PublicNotification")
              .doc(deviceIdentifier
                  .toString()
                  .replaceAll("/", "")
                  .replaceAll(" ", ""))
              .update({"NotificationToken": "Disable Notification"});
        }
      } else {
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceIdentifier = androidInfo.androidId;
          if (enable) {
            FirebaseFirestore.instance
                .collection("PublicNotification")
                .where("NotificationToken",
                    isEqualTo: deviceIdentifier!
                        .toString()
                        .replaceAll("/", "")
                        .replaceAll(" ", ""))
                .get()
                .then((value) {
              if (value.size == 0) {
                FirebaseFirestore.instance
                    .collection("PublicNotification")
                    .doc(deviceIdentifier!
                        .replaceAll("/", "")
                        .replaceAll(" ", ""))
                    .set({"NotificationToken": token});
              }
            });
            FirebaseFirestore.instance
                .collection("UserProfile")
                .doc(userUid)
                .update({"WebNotificationToken": token});
          } else {
            FirebaseFirestore.instance
                .collection("UserProfile")
                .doc(userUid)
                .update({"WebNotificationToken": "Disable Notification"});

            FirebaseFirestore.instance
                .collection("PublicNotification")
                .doc(deviceIdentifier
                    .toString()
                    .replaceAll("/", "")
                    .replaceAll(" ", ""))
                .update({"NotificationToken": "Disable Notification"});
          }
        } else if (Platform.isIOS) {
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          deviceIdentifier = iosInfo.identifierForVendor;
          if (enable) {
            FirebaseFirestore.instance
                .collection("PublicNotification")
                .where("NotificationToken",
                    isEqualTo: deviceIdentifier!
                        .replaceAll("/", "")
                        .replaceAll(" ", ""))
                .get()
                .then((value) {
              if (value.size == 0) {
                FirebaseFirestore.instance
                    .collection("PublicNotification")
                    .doc(deviceIdentifier!
                        .replaceAll("/", "")
                        .replaceAll(" ", ""))
                    .set({"NotificationToken": token});
              }
            });
            FirebaseFirestore.instance
                .collection("UserProfile")
                .doc(userUid)
                .update({"WebNotificationToken": token});
          } else {
            FirebaseFirestore.instance
                .collection("UserProfile")
                .doc(userUid)
                .update({"WebNotificationToken": "Disable Notification"});

            FirebaseFirestore.instance
                .collection("PublicNotification")
                .doc(deviceIdentifier
                    .toString()
                    .replaceAll("/", "")
                    .replaceAll(" ", ""))
                .update({"NotificationToken": "Disable Notification"});
          }
        } else if (Platform.isLinux) {
          LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
          deviceIdentifier = linuxInfo.machineId;
          if (enable) {
            FirebaseFirestore.instance
                .collection("PublicNotification")
                .where("NotificationToken",
                    isEqualTo: deviceIdentifier!
                        .replaceAll("/", "")
                        .replaceAll(" ", ""))
                .get()
                .then((value) {
              if (value.size == 0) {
                FirebaseFirestore.instance
                    .collection("PublicNotification")
                    .doc(deviceIdentifier!
                        .replaceAll("/", "")
                        .replaceAll(" ", ""))
                    .set({"NotificationToken": token});
              }
            });
            FirebaseFirestore.instance
                .collection("UserProfile")
                .doc(userUid)
                .update({"WebNotificationToken": token});
          }
        } else {
          FirebaseFirestore.instance
              .collection("UserProfile")
              .doc(userUid)
              .update({"WebNotificationToken": "Disable Notification"});

          FirebaseFirestore.instance
              .collection("PublicNotification")
              .doc(deviceIdentifier
                  .toString()
                  .replaceAll("/", "")
                  .replaceAll(" ", ""))
              .update({"NotificationToken": "Disable Notification"});
        }
      }
    });
  }
}
