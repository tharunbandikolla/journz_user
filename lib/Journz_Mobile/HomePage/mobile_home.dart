import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:journz_web/Journz_Mobile/HomePage/mobile_app_drawer.dart';
import '../../Journz_Large_Screen/NewHomePage/Components/footer.dart';
import '../../Journz_Large_Screen/NewHomePage/Cubits/check_favourite_categories_cubit/check_favourite_categories_cubit.dart';
import '../../Journz_Large_Screen/NewHomePage/LocalDatabase/HiveArticleSubtypeModel/hive_article_subtype_model.dart';
import '../../Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import '../../Journz_Large_Screen/utils/routes.dart';
import '/Journz_Mobile/HomePage/mobile_home_page_footer.dart';
import '/Journz_Large_Screen/HiveArticlesModel/GetArticlesFromCloud/get_articles_from_cloud_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/get_articles_subtype_cubit/get_article_subtype_cubit.dart';
import 'package:velocity_x/velocity_x.dart';
import 'mobile_home_page_body_center_pane.dart';
import 'mobile_home_page_header.dart';

class MobileHome extends StatefulWidget {
  final bool? wantSearchBar;
  const MobileHome({Key? key, this.wantSearchBar}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MobileHome> {
  //late ShowCurrentlySelectedSubtypeCubit showCurrentlySelectedSubtypeCubit;

  CheckuserloginedState? userStat;

  @override
  void didChangeDependencies() {
    //context.read<CheckuserloginedCubit>().checkLogin();
    // checkConnection();
    /* showCurrentlySelectedSubtypeCubit =
        context.read<ShowCurrentlySelectedSubtypeCubit>(); */
    super.didChangeDependencies();
  }

  checkConnection() async {
    getDataFromDB();
    updateWebNotificationToken();
  }

  invokeselectFavCategory(bool val) {
    if (val) {
      showFavouriteCategoriesDialog();
    }
  }

  void showFavouriteCategoriesDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BlocProvider(
            create: (context) => CheckFavouriteCategoriesCubit(
                initialData: userStat!.favCategories!),
            child: BlocBuilder<CheckFavouriteCategoriesCubit,
                CheckFavouriteCategoriesState>(
              builder: (context, checkFavstate) {
                return Dialog(
                  child: Container(
                    width: context.screenWidth,
                    height: context.screenWidth * 1.25,
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
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
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
                                                  context.screenWidth * 0.065,
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
                                .width(context.screenWidth)
                                .height(context.screenWidth * 0.75)
                                .make();
                          },
                        ),
                        ElevatedButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('UserProfile')
                                  .doc(userStat?.userUid)
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
      },
    );
  }

  updateWebNotificationToken() {
    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                "BOuQ9ODWQnHDc4ObmZHYEZ9dIjKcszc2EpRVv6e8sAGs4t05tfBpilhPatLnwmqHMa4Pn5UnjIy978P_fHu3kvM")
        .then((token) {
      FirebaseFirestore.instance
          .collection("PublicNotification")
          .where("NotificationToken", isEqualTo: token)
          .get()
          .then((value) {
        if (value.size == 0) {
          FirebaseFirestore.instance
              .collection("PublicNotification")
              .doc()
              .set({"NotificationToken": token});
        }
      });
    });
  }

  getDataFromDB() {
    context.read<GetArticleSubtypeCubit>().addSubtypeToHiveDb();
    context.read<GetArticlesFromCloudCubit>().getArticlesfromCloud();
  }

  @override
  Widget build(BuildContext context) {
    // getDataFromDB();
    context.read<CheckuserloginedCubit>().checkLogin();
    return BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
      builder: (context, userState) {
        userStat = userState;
        return Scaffold(
          drawerEdgeDragWidth: 0,
          drawer: MobileDrawer(
              userState: userState,
              showFAvCategory:
                  invokeselectFavCategory) /* Drawer(
            child: Column(children: [
              userState.isLoggined!
                  ? Container()
                  : TextButton(
                      onPressed: () {
                        context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeRoute,
                              queryParameters: {"Page": "/MobileSignUp"}),
                        );
                      },
                      child: Text("Sign Up")),
              userState.isLoggined!
                  ? ElevatedButton(
                      onPressed: () {
                        if (userState.isLoggined!) {
                          FirebaseAuth.instance.signOut().then((value) =>
                              context
                                  .read<CheckuserloginedCubit>()
                                  .checkLogin());
                        }
                      },
                      child: Text("Sign Out"))
                  : Container(),
              userState.isLoggined!
                  ? Container()
                  : TextButton(
                      onPressed: () {
                        context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeRoute,
                              queryParameters: {"Page": "/MobileLogin"}),
                        );
                      },
                      child: Text("Login"))
            ]),
          ) */
          ,
          body: BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
            builder: (context, userState) {
              return Container(
                height: context.screenHeight,
                width: context.screenWidth,
                child: Column(
                  children: [
                    //SaiHeader(),
                    MobileHomePageHeader(wantSearchBar: true),
                    SizedBox(height: context.screenHeight * 0.015),
                    BlocProvider(
                      create: (context) => ShowCurrentlySelectedSubtypeCubit(
                          userState: userState.isLoggined!),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //HomePageHeader(wantSearchBar: widget.wantSearchBar),
                            Container(
                              width: context.screenWidth,
                              //height: context.screenHeight * 0.865,
                              //color: Colors.white,
                              child: MobileBodyCenterPane(
                                  /* showCurrentSubtypeNameCubit: context
                                        .read<ShowCurrentlySelectedSubtypeCubit>(), */
                                  ),
                            ),
                            SizedBox(height: context.screenHeight * 0.03),

                            CommonHomePageFooter()
                          ],
                        ),
                      ),
                    )
                        .box
                        .width(context.screenWidth)
                        .height(context.screenHeight * 0.9)
                        .make(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
