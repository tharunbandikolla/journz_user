import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_header.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/routes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void didChangeDependencies() {
    context.read<CheckuserloginedCubit>().checkLogin();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
            builder: (context, userState) {
      return userState.isLoggined!
          ? Container(
              width: context.screenWidth,
              height: context.screenHeight,
              child: Column(children: [
                HomePageHeader(wantSearchBar: true, fromMobile: false),
                Container(
                    width: context.screenWidth,
                    height: context.screenHeight * 0.915,
                    child: Row(children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              userState.isLoggined!
                                  ? userState.photoUrl != "WithoutImage"
                                      ? Container(
                                          width: context.screenWidth * 0.1,
                                          height: context.screenHeight * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(250),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      userState.photoUrl!))),
                                        )
                                      : Image.asset("assets/images/logo.png")
                                  : Container(),

                              userState.name!.text.xl3.semiBold.make(),
                              userState.role == "ContentWriter"
                                  ? "Author".text.xl3.semiBold.make()
                                  : userState.role!.text.xl3.semiBold.make(),
                              userState.email!.text.xl.semiBold.make(),
                              ("${userState.countryCode} ${userState.mobileNumber}")
                                  .text
                                  .xl
                                  .semiBold
                                  .make(),

                              //  userState.email!.text.xl2.semiBold.make(),
                              (userState.stateName == null
                                      ? userState.country!
                                      : (userState.stateName! +
                                          ", " +
                                          userState.country!))
                                  .text
                                  .xl2
                                  .semiBold
                                  .make(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (userState.facebook! ==
                                          "Add Facebook Link") {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Please Add Your Facebook Profile in Edit Section'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('close'))
                                                ],
                                              );
                                            });
                                      } else {
                                        if (userState.facebook!
                                                .split("https://")
                                                .length ==
                                            1) {
                                          launch(
                                              "https://${userState.facebook!}");
                                        } else {
                                          launch(userState.facebook!);
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: context.screenWidth * 0.045,
                                      height: context.screenHeight * 0.085,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(250),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/facebookIcon.png'))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (userState.twitter! ==
                                          "Add Twitter Link") {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Please Add Your Twitter Profile in Edit Section'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('close'))
                                                ],
                                              );
                                            });
                                      } else {
                                        if (userState.twitter!
                                            .toString()
                                            .trim()
                                            .toLowerCase()
                                            .contains("www")) {
                                          if (userState.twitter!
                                                  .split("https://")
                                                  .length ==
                                              1) {
                                            launch(
                                                "https://${userState.twitter!}");
                                          } else {
                                            launch(userState.twitter!);
                                          }
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Please Check The URL Provided in Your Profile'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('close'))
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: context.screenWidth * 0.045,
                                      height: context.screenHeight * 0.085,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(250),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/twitterIcon.png'))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if ((userState.linkedin! ==
                                          "Add Linkedin Link")) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Please Add Your LinkedIn Profile in Edit Section'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('close'))
                                                ],
                                              );
                                            });
                                      } else {
                                        if (userState.linkedin!
                                                .split("https://")
                                                .length ==
                                            1) {
                                          launch(
                                              "https://${userState.linkedin!}");
                                        } else {
                                          launch(userState.linkedin!);
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: context.screenWidth * 0.045,
                                      height: context.screenHeight * 0.085,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(250),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/linkedinIcon.png'))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if ((userState.instagram! ==
                                          "Add Instagram Link")) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Please Add Your Instagram Profile in Edit Section'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('close'))
                                                ],
                                              );
                                            });
                                      } else {
                                        if (userState.instagram!
                                                .split("https://")
                                                .length ==
                                            1) {
                                          launch(
                                              "https://${userState.instagram!}");
                                        } else {
                                          launch(userState.instagram!);
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: context.screenWidth * 0.035,
                                      height: context.screenHeight * 0.07,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(250),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/images/instagram.png'))),
                                    ),
                                  ),
                                ],
                              )
                                  .box
                                  .height(context.screenHeight * 0.1)
                                  .width(context.screenWidth * 0.25)
                                  .make()
                            ],
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: ElevatedButton.icon(
                                  onPressed: () {
                                    context.vxNav.push(
                                        Uri(
                                            path: MyRoutes.homeRoute,
                                            queryParameters: {
                                              "Page": "/UserProfile/EditProfile"
                                            }),
                                        params: {'UserData': userState});
                                  },
                                  icon: Icon(Icons.edit),
                                  label: Text('Edit')))
                        ],
                      )
                          .box
                          .p8
                          .width(context.screenWidth * 0.3)
                          .height(context.screenHeight * 0.9)
                          .make(),
                      Container(
                        height: context.screenHeight * 0.93,
                        width: 2,
                        color: Colors.black,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        UserDataInRow(
                                            left: "Date Of Birth",
                                            right: userState.dateOfBirth != null
                                                ? userState.dateOfBirth!
                                                : "Update Date Of Birth"),
                                        UserDataInRow(
                                            left: "Gender",
                                            right: userState.gender != null
                                                ? userState.gender!
                                                : "Update Gender"),
                                        userState.role! == "ContentWriter"
                                            ? UserDataInRow(
                                                left: "Published Articles",
                                                right: userState
                                                    .noOfPublishedArticles
                                                    .toString())
                                            : Container()
                                      ])
                                      .box
                                      .p16
                                      .width(context.screenWidth * 0.349)
                                      .height(context.screenHeight * 0.35)
                                      .make(),
                                  Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        UserDataInRow(
                                            left: "Anniversary Date",
                                            right: userState.anniversaryDate !=
                                                    null
                                                ? userState.anniversaryDate!
                                                : "Update Anniversary Date"),
                                        UserDataInRow(
                                            left: "Marital Status",
                                            right:
                                                userState.maritalStatus != null
                                                    ? userState.maritalStatus!
                                                    : "Update Marital Status"),
                                        UserDataInRow(
                                            left: "Work",
                                            right: userState.occupation != null
                                                ? userState.occupation!
                                                : "Update Work")
                                      ])
                                      .box
                                      .p16
                                      .width(context.screenWidth * 0.349)
                                      .height(context.screenHeight * 0.35)
                                      .make(),
                                ]),
                            Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                  "Bio"
                                      .text
                                      .xl2
                                      .semiBold
                                      .make()
                                      .box
                                      .width(context.screenWidth * 0.15)
                                      .height(context.screenHeight * 0.05)
                                      .make(),
                                  SizedBox(height: 4),
                                  userState.bio != null
                                      ? Html(data: userState.bio)
                                      : "You can Update your Bio by Expressing Who You Are"
                                          .text
                                          .medium
                                          .make()
                                          .scrollVertical()
                                          .box
                                          .width(context.screenWidth * 0.698)
                                          .height(context.screenHeight * 0.44)
                                          .make()
                                ])
                                .box
                                .p16
                                .width(context.screenWidth * 0.698)
                                .height(context.screenHeight * 0.56)
                                .make(),
                          ])
                    ]))
              ]))
          : Center(
              child: CircularProgressIndicator(),
            );
    }));
  }
}

urlValidation(String url) {}

class UserDataInRow extends StatelessWidget {
  final String left, right;
  const UserDataInRow({Key? key, required this.left, required this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        left
            .trim()
            .text
            .xl
            .semiBold
            .make()
            .box
            .alignCenterLeft
            .width(context.screenWidth * 0.125)
            .make(),
        "-".text.xl.semiBold.make(),
        SizedBox(width: context.screenWidth * 0.0075),
        right
            .trim()
            .text
            .xl
            .semiBold
            .make()
            .box
            .alignCenterLeft
            .width(context.screenWidth * 0.15)
            .make(),
      ],
    )
        .box
        .height(context.screenHeight * 0.065)
        .width(context.screenWidth * 0.35)
        .make();
  }
}
