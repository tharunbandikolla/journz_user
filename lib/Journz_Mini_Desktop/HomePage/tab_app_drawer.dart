import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:journz_web/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:journz_web/Journz_Large_Screen/NewHomePage/Cubits/leftpane_expansiontile_cubit/leftpane_expansion_tile_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Journz_Large_Screen/Common/Data/author_request_terms.dart';
import '../../Journz_Large_Screen/HiveArticlesModel/LocalArticleModel/code_article_model.dart';
import '../../Journz_Large_Screen/NewHomePage/Cubits/check_favourite_categories_cubit/check_favourite_categories_cubit.dart';
import '../../Journz_Large_Screen/NewHomePage/Cubits/notification_on_off_cubit/notificationonoff_cubit.dart';
import '../../Journz_Large_Screen/NewHomePage/LocalDatabase/HiveArticleSubtypeModel/hive_article_subtype_model.dart';
import '../../Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import '../../Journz_Large_Screen/utils/routes.dart';

class TabDrawer extends StatefulWidget {
  final CheckuserloginedState userState;
  const TabDrawer({Key? key, required this.userState}) : super(key: key);

  @override
  State<TabDrawer> createState() => _TabDrawerState();
}

class _TabDrawerState extends State<TabDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Card(
          elevation: 8,
          child: Container(
            width: context.screenWidth,
            height: context.screenWidth * 0.325,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.userState.isLoggined!
                    ? widget.userState.photoUrl == "images/fluenzologo.png"
                        ? CircleAvatar(
                            maxRadius: 45,
                            backgroundColor: Colors.black,
                            backgroundImage:
                                AssetImage("assets/images/journzlogo1.png"))
                        : CircleAvatar(
                            maxRadius: 45,
                            backgroundImage:
                                NetworkImage(widget.userState.photoUrl!),
                          )
                    : CircleAvatar(
                        maxRadius: 45,
                        backgroundColor: Colors.black,
                        backgroundImage:
                            AssetImage("assets/images/journzlogo1.png")),
                widget.userState.isLoggined!
                    ? widget.userState.name!.text.xl2.semiBold.make()
                    : "Hii Journz".text.xl2.semiBold.make(),
                widget.userState.role == "ContentWriter"
                    ? "Author".text.xl.semiBold.make()
                    : widget.userState.role!.text.xl.semiBold.make(),
              ],
            ),
          ),
        ),
        BlocBuilder<LeftpaneExpansionTileCubit, LeftpaneExpansionTileState>(
          builder: (context, expansionState) {
            return Container(
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        context
                            .read<LeftpaneExpansionTileCubit>()
                            .whatSection("Articles");
                        //context.vxNav.popToRoot();
                      },
                      child: "Articles"
                          .text
                          .xl2
                          .white
                          .semiBold
                          .make()
                          .box
                          .width(context.screenWidth * 0.95)
                          .height(context.screenHeight * 0.08)
                          .p12
                          .alignCenter
                          .blue400
                          .make()),
                  AnimatedContainer(
                      height: widget.userState.isLoggined!
                          ? expansionState.expandablePane == "Articles"
                              ? widget.userState.role == "ContentWriter"
                                  ? context.screenHeight * 0.3
                                  : context.screenHeight * 0.225
                              : 0
                          : 0,
                      width: context.screenWidth * 0.95,
                      duration: Duration(milliseconds: 300),
                      child: Column(children: [
                        widget.userState.isLoggined!
                            ? InkWell(
                                onTap: () {
                                  showFavouriteCategoriesDialog(
                                      widget.userState);
                                },
                                child: "Favourite Categories"
                                    .text
                                    .xl
                                    .semiBold
                                    .make()
                                    .box
                                    .color(Colors.grey.shade200)
                                    .width(context.screenWidth * 0.95)
                                    .height(context.screenHeight * 0.075)
                                    .p12
                                    .alignCenter
                                    .make(),
                              )
                            : Container(),
                        widget.userState.isLoggined!
                            ? widget.userState.role! == "ContentWriter"
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
                                            "articleData": CodeArticleData()
                                          });
                                    },
                                    child: "Create Article"
                                        .text
                                        .xl
                                        .semiBold
                                        .make()
                                        .box
                                        .color(Colors.grey.shade200)
                                        .width(context.screenWidth * 0.95)
                                        .height(context.screenHeight * 0.075)
                                        .p12
                                        .alignCenter
                                        .make(),
                                  )
                                : Container()
                            : Container(),
                        widget.userState.isLoggined!
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
                                    .width(context.screenWidth * 0.95)
                                    .height(context.screenHeight * 0.075)
                                    .p12
                                    .alignCenter
                                    .make(),
                              )
                            : Container(),
                        widget.userState.isLoggined!
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
                                    .width(context.screenWidth * 0.95)
                                    .height(context.screenHeight * 0.075)
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
                        .width(context.screenWidth * 0.95)
                        .height(context.screenHeight * 0.08)
                        .p12
                        .alignCenter
                        .blue400
                        .make(),
                  ),
                  AnimatedContainer(
                    width: context.screenWidth * 0.95,
                    height: widget.userState.isLoggined!
                        ? expansionState.expandablePane == "News"
                            ? context.screenHeight * 0.3
                            : 0
                        : 0,
                    duration: Duration(milliseconds: 300),
                    child: Column(children: [
                      widget.userState.isLoggined!
                          ? InkWell(
                              onTap: () {},
                              child: "Favourite News"
                                  .text
                                  .xl
                                  .semiBold
                                  .make()
                                  .box
                                  .color(Colors.grey.shade200)
                                  .width(context.screenWidth * 0.95)
                                  .height(context.screenHeight * 0.075)
                                  .p12
                                  .alignCenter
                                  .make(),
                            )
                          : Container(),
                      widget.userState.isLoggined!
                          ? widget.userState.role! == "ContentWriter"
                              ? InkWell(
                                  onTap: () {},
                                  child: "Create News"
                                      .text
                                      .xl
                                      .semiBold
                                      .make()
                                      .box
                                      .color(Colors.grey.shade200)
                                      .width(context.screenWidth * 0.95)
                                      .height(context.screenHeight * 0.075)
                                      .p12
                                      .alignCenter
                                      .make(),
                                )
                              : Container()
                          : Container(),
                      widget.userState.isLoggined!
                          ? InkWell(
                              onTap: () {},
                              child: "Published News"
                                  .text
                                  .xl
                                  .semiBold
                                  .make()
                                  .box
                                  .color(Colors.grey.shade200)
                                  .width(context.screenWidth * 0.95)
                                  .height(context.screenHeight * 0.075)
                                  .p12
                                  .alignCenter
                                  .make(),
                            )
                          : Container(),
                      widget.userState.isLoggined!
                          ? InkWell(
                              onTap: () {},
                              child: "Saved News"
                                  .text
                                  .xl
                                  .semiBold
                                  .make()
                                  .box
                                  .color(Colors.grey.shade200)
                                  .width(context.screenWidth * 0.95)
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
                        .width(context.screenWidth * 0.95)
                        .height(context.screenHeight * 0.085)
                        .p12
                        .alignCenter
                        .blue400
                        .make(),
                  ),
                  AnimatedContainer(
                    width: context.screenWidth * 0.95,
                    height: widget.userState.isLoggined!
                        ? expansionState.expandablePane == "Settings"
                            ? context.screenHeight * 0.3
                            : 0
                        : 0,
                    duration: Duration(milliseconds: 300),
                    child: Column(children: [
                      widget.userState.isLoggined!
                          ? InkWell(
                              onTap: () {
                                if (widget.userState.isLoggined!) {
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
                                  .width(context.screenWidth * 0.95)
                                  .height(context.screenHeight * 0.075)
                                  .p12
                                  .alignCenter
                                  .make())
                          : Container(),
                      widget.userState.isLoggined!
                          ? widget.userState.role == "User"
                              ? InkWell(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('UserProfile')
                                        .doc(widget.userState.userUid)
                                        .get()
                                        .then((value) {
                                      if (value.data()!['RequestAuthor'] ==
                                          "False") {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    Text("Terms & Condition"),
                                                content: Text(authorTerms),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Close')),
                                                  TextButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'UserProfile')
                                                            .doc(widget
                                                                .userState
                                                                .userUid)
                                                            .update({
                                                          "RequestAuthor":
                                                              "True"
                                                        }).then((value) =>
                                                                Navigator.pop(
                                                                    context));
                                                      },
                                                      child: Text('Accept'))
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
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Close'))
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
                                      .width(context.screenWidth * 0.95)
                                      .height(context.screenHeight * 0.075)
                                      .p12
                                      .alignCenter
                                      .make())
                              : Container()
                          : Container(),
                      /* ElevatedButton(
                                          onPressed: () {
                                            SharedPreferences.getInstance()
                                                .then((preference) {
                                              HiveArticlesTitlePreferences()
                                                  .storeArticleName(preference, []);
                                              Boxes.getArticleFromCloud().clear();
                                              Boxes.getArticleSubtypeFromCloud()
                                                  .clear();
                                              SubtypeNamePreferences()
                                                  .storeSubtypeName(preference, null);
                                            });
                                            /*  FirebaseFirestore.instance
                                                .collection(
                                                    "GeneralAppUserNotificationToken")
                                                .get()
                                                .then((value) {
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance
                                                    .collection("PublicNotification")
                                                    .add({
                                                  "NotificationToken": (element
                                                          .data()["NotificationToken"])
                                                      .toString()
                                                });
                                              });
                                            }); */
                                          },
                                          child: Text("Test")), */
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
                                            builder:
                                                (context, notificationState) {
                                              context
                                                  .read<
                                                      NotificationonoffCubit>()
                                                  .toggleNotification(widget
                                                      .userState.userUid!);
                                              return AlertDialog(
                                                title: Text("Alert..!"),
                                                content: Text(
                                                    "Are You Sure You want to ${notificationState.notificationState}.?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("No")),
                                                  TextButton(
                                                      onPressed: () {
                                                        if (notificationState
                                                                .notificationState ==
                                                            "Disable Notification") {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "UserProfile")
                                                              .doc(widget
                                                                  .userState
                                                                  .userUid!)
                                                              .update({
                                                            "WebNotificationToken":
                                                                "Disable Notification"
                                                          });
                                                          /*     FirebaseFirestore
                                                                              .instance
                                                                              .collection(
                                                                                  "GeneralAppUserNotification")
                                                                              .doc(userState
                                                                                  .userUid!)
                                                                              .update({
                                                                            "NotificationToken":
                                                                                "Disable Notification"
                                                                          }); */
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "GeneralWebUserNotification")
                                                              .doc(widget
                                                                  .userState
                                                                  .userUid!)
                                                              .update({
                                                            "WebNotificationToken":
                                                                "Disable Notification"
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        } else {
                                                          FirebaseMessaging
                                                              .instance
                                                              .getToken(
                                                                  vapidKey:
                                                                      "BOuQ9ODWQnHDc4ObmZHYEZ9dIjKcszc2EpRVv6e8sAGs4t05tfBpilhPatLnwmqHMa4Pn5UnjIy978P_fHu3kvM")
                                                              .then((token) {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "UserProfile")
                                                                .doc(widget
                                                                    .userState
                                                                    .userUid!)
                                                                .update({
                                                              "WebNotificationToken":
                                                                  token
                                                            });
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
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "GeneralWebUserNotification")
                                                                .doc(widget
                                                                    .userState
                                                                    .userUid!)
                                                                .update({
                                                              "WebNotificationToken":
                                                                  token
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        }
                                                      },
                                                      child: Text("Yes"))
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
                                  .width(context.screenWidth * 0.95)
                                  .height(context.screenHeight * 0.075)
                                  .p12
                                  .alignCenter
                                  .make());
                        },
                      )
                    ]),
                  ),
                ],
              ),
            );
          },
        ),
        Spacer(),
        widget.userState.isLoggined!
            ? ElevatedButton(
                onPressed: () {
                  if (widget.userState.isLoggined!) {
                    FirebaseAuth.instance.signOut().then((value) =>
                        context.read<CheckuserloginedCubit>().checkLogin());
                  }
                },
                child: Text("Sign Out"))
            : Container(),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.userState.isLoggined!
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeRoute,
                              queryParameters: {"Page": "/Login"}),
                        );
                      },
                      child: Text("Login")),
              widget.userState.isLoggined!
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeRoute,
                              queryParameters: {"Page": "/SignUp"}),
                        );
                      },
                      child: Text("Sign Up")),
            ]).box.py8.make()
      ]),
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
}
