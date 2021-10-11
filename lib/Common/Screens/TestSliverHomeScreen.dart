/* import 'package:Journz/Common/Screens/RecommendedUpdate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentNumbers/commentnumbers_cubit.dart';
import '/Common/Helper/LoadDataPartByPartCubit/loaddatapartbypart_cubit.dart';
import '/Common/Helper/TabBarIndexChangerCubit/tabbarindexchanger_cubit.dart';
import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import '/Common/Widgets/AlertDialogBoxWidget.dart';
import '/HomeScreen/Bloc/FavouriteCategoryCubit/favouritecategory_cubit.dart';
import '/HomeScreen/Bloc/FavouritePreferencesCubit/favouritepreference_cubit.dart';
import '/HomeScreen/Helper/FavArticleSharedPreferences.dart';
import '/UserProfile/Screen/UserNotLoggedInScreen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleReportCubit/articlereport_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleTitleCubit/articletitle_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewCubit/articlesdetail_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
import '/ArticleDetailView/Screen/ArticleDetaillViewScreen.dart';
import '/Articles/DataModel/ArticlesModel.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Common/Widgets/AricleCard.dart';
import '/HomeScreen/Bloc/ArticleCubit/article_cubit.dart';
import '/SearchArticles/Cubit/cubit/searchcubit_cubit.dart';
import '/SearchArticles/Screen/SearchArticlesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class SliverHomeScreen extends StatefulWidget {
  const SliverHomeScreen({Key? key}) : super(key: key);

  @override
  _SliverHomeScreenState createState() => _SliverHomeScreenState();
}

class _SliverHomeScreenState extends State<SliverHomeScreen>
    with TickerProviderStateMixin {
  TabController? _controller;
  List<TabData> list = [];

  DocumentSnapshot<Object?>? lastDocData;

  List<DocumentSnapshot<Object?>>? listData;

  int? docLength;

  ScrollController scrollController = ScrollController();
  var pref;

  var tokenId;
  var appUserName;
  var msgUpdate;

  var versionNo, versionNumberFromServer, updateType;
  versionControl() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection('UserProfile')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        appUserName = await value.data()?['FirstName'] ?? 'Guest';
        msgUpdate = await value.data()?['Message'] ??
            "To help you better we came up with more updates.\nThanks for being part of Journz family.";
      });
    } else {
      appUserName = 'Guest';
      msgUpdate =
          "To help you better we came up with more updates.\nThanks for being part of Journz family.";
    }
    FirebaseFirestore.instance
        .collection('JournzAppVersion')
        .orderBy('CreatedTime', descending: true)
        .get()
        .then((value) async {
      print('nnn doc id for dialog ${value.docs.first.id}');
      versionNumberFromServer = await value.docs.first.data()['VersionNumber'];
      updateType = await value.docs.first.data()['UpdateType'];
    });
    PackageInfo p = await PackageInfo.fromPlatform();
    versionNo = p.version;
    Future.delayed(Duration(seconds: 4), () {
      print('version $versionNo $versionNumberFromServer  $updateType');
      if (versionNo != null && versionNumberFromServer != null) {
        if (versionNo != versionNumberFromServer) {
          showDialog(
              barrierDismissible: false,
              /*    isDismissible: updateType == 'Forced'
                  ? false
                  : updateType == 'Recommended'
                      ? true
                      : true,
              enableDrag: updateType == 'Forced'
                  ? false
                  : updateType == 'Recommended'
                      ? true
                      : true,*/
              context: context,
              builder: (context) {
                return WillPopScope(
                  onWillPop: () {
                    return Future.value(false);
                  },
                  child: Container(
                    //color: Colors.transparent,

                    width: context.screenWidth,
                    height: context.screenHeight,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Colors.grey[200]!,
                                Colors.grey[500]!
                              ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight)),
                          //  color: Colors.grey.withOpacity(1),
                          width: context.screenWidth * 0.75,
                          height: context.screenHeight * 0.45,
                        )
                            .box
                            .neumorphic(color: Colors.black, elevation: 30)
                            .make()
                            .positioned(
                                left: context.screenWidth * 0.125,
                                top: context.screenHeight * 0.325),
                        VxArc(
                                height: 20,
                                edge: VxEdge.TOP,
                                arcType: VxArcType.CONVEY,
                                child: Container(
                                        color: Colors.white,
                                        width: context.screenWidth * 0.75,
                                        height: context.screenHeight * 0.3)
                                    .box
                                    .neumorphic(
                                        color: Colors.black, elevation: 30)
                                    .make())
                            .positioned(
                                left: context.screenWidth * 0.125,
                                top: context.screenHeight * 0.5),
                        RotationTransition(
                          turns: AlwaysStoppedAnimation(1200 / 1400),
                          child: Icon(
                            FontAwesomeIcons.broom,
                            color: Colors.grey,
                            size: 55,
                          ),
                        ).positioned(
                            left: context.screenWidth * 0.4025,
                            top: context.screenHeight * 0.41),
                        RotationTransition(
                          turns: AlwaysStoppedAnimation(2.87466666667),
                          child: Icon(
                            FontAwesomeIcons.rocket,
                            color: Colors.grey,
                            size: 100,
                          ),
                        ).positioned(
                            left: context.screenWidth * 0.35,
                            top: context.screenHeight * 0.32),
                        "Hi $appUserName"
                            .text
                            .bold
                            .center
                            .black
                            .xl2
                            .makeCentered()
                            .box
                            //.coolGray200
                            .width(context.screenWidth * 0.75)
                            .height(context.screenWidth * 0.175)
                            .p12
                            .make()
                            .positioned(
                                left: context.screenWidth * 0.125,
                                top: context.screenHeight * 0.525),
                        "$msgUpdate"
                            .text
                            .justify
                            .black
                            .xl
                            .make()
                            .box
                            //.neumorphic(color: Colors.black, elevation: 30)
                            .height(context.screenWidth * 0.4)
                            .width(context.screenWidth * 0.65)
                            .make()
                            .positioned(
                                left: context.screenWidth * 0.175,
                                top: context.screenHeight * 0.6),
                        HStack(
                          [
                            updateType != "Forced"
                                ? ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: "Ignore".text.xl.bold.makeCentered())
                                : Container(),
                            ElevatedButton(
                                onPressed: () {
                                  launch('https://play.google.com/store/apps/details?id=in.journz.journz')
                                      .then((value) => Navigator.pop(context));
                                },
                                child: "Update".text.xl.bold.makeCentered())
                            /* .box
                                .height(context.screenWidth * 0.18)
                                //.neumorphic(color: Colors.black, elevation: 30)
                                .width(updateType != 'Forced'
                                    ? context.screenWidth * 0.37
                                    : context.screenWidth * 0.75)
                                //             .black
                                .p12
                                .make(), */
                          ],
                          alignment: updateType != 'Forced'
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.center,
                        )
                            .box
                            .width(context.screenWidth * 0.75)
                            // .neumorphic(color: Colors.black, elevation: 30)
                            .make()
                            .positioned(
                                left: context.screenWidth * 0.125,
                                top: context.screenHeight * 0.73),
                      ],
                    ),
                  ),
                );

                /* RecommendedUpdateDialog(
                  mainMsg:
                      'To help you better we came up with more updates.Thanks for being part of Journz family.',
                ); */
                /* WillPopScope(
                  onWillPop: () {
                    return Future.value(false);
                  },
                  child: Container(
                    height: context.screenWidth * 0.75,
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: VStack(
                      [
                        updateType == 'Forced'
                            ? "Please Update The App We Have Major Changes"
                                .text
                                .bold
                                .center
                                .xl
                                .makeCentered()
                                .box
                                .px24
                                .py8
                                .make()
                            : "Please Update The App We Have Some Changes"
                                .text
                                .bold
                                .center
                                .xl
                                .makeCentered()
                                .box
                                .px24
                                .py8
                                .make(),
                        InkWell(
                                onTap: () {},
                                child:
                                    Image.asset('images/GooglePlayButton.png'))
                            .box
                            .width(context.screenWidth * 0.75)
                            .height(context.screenWidth * 0.3)
                            .px24
                            .py8
                            .makeCentered(),
                        updateType != 'Forced'
                            ? InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: "Dismiss"
                                        .text
                                        .bold
                                        .center
                                        .xl
                                        .makeCentered())
                                .box
                                .height(context.screenWidth * 0.15)
                                .px24
                                .py8
                                .makeCentered()
                            : Container()
                      ],
                      alignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                );*/
              });
        }
      }
    });
  }

  getSharedPref() async {
    pref = await SharedPreferences.getInstance();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    tokenId = await messaging.getToken();
  }

  String? userRole;

  List<dynamic> favCategories = [];
  getFavouriteArticlesCategory() async {
    context.read<FavouritecategoryCubit>().getFavCategories();
  }

  removeCategoryBasedNotificationSubscription(String subType) {
    FirebaseFirestore.instance
        .collection('ArticleSubtype')
        .where('SubType', isEqualTo: subType)
        .get()
        .then((value) async {
      if (value.size != 0) {
        FirebaseFirestore.instance
            .collection('ArticleSubtype')
            .doc(value.docs.first.id)
            .get()
            .then((val) async {
          List<dynamic> serverList = [];
          serverList = val.data()!['PeopleSubscribed'];
          print('Subscribtion ${serverList.length}');
          for (int i = 0; i <= serverList.length - 1; i++) {
            print('subs $i');
            if (serverList[i]['UserUid'] ==
                FirebaseAuth.instance.currentUser!.uid) {
              print(
                  'subs token ${serverList[i]['UserUid']} Already SubScribed so Removing');

              serverList.removeAt(i);

              FirebaseFirestore.instance
                  .collection('ArticleSubtype')
                  .doc(value.docs.first.id)
                  .update({'PeopleSubscribed': serverList});
            }
            /*else {
              if (tokenId != null) {
                Map<String, dynamic> data = {
                  'UserUid': FirebaseAuth.instance.currentUser!.uid,
                  'Token': tokenId
                };
                serverList.add(data);
                print('subs token User Not Found SubScribed ');

                FirebaseFirestore.instance
                    .collection('ArticleSubtype')
                    .doc(value.docs.first.id)
                    .update({'PeopleSubscribed': serverList});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Error in Getting Device Id, SubScription Failed')));
              }
            }*/
          }
        });
      }
    });
  }

  addCategoryBasedNotificationSubscription(String subType) {
    FirebaseFirestore.instance
        .collection('ArticleSubtype')
        .where('SubType', isEqualTo: subType)
        .get()
        .then((value) async {
      if (value.size != 0) {
        FirebaseFirestore.instance
            .collection('ArticleSubtype')
            .doc(value.docs.first.id)
            .get()
            .then((val) async {
          List<dynamic> serverList = [];
          serverList = val.data()!['PeopleSubscribed'];
          print('Subscribtion ${serverList.length}');

          if (tokenId != null) {
            Map<String, dynamic> data = {
              'UserUid': FirebaseAuth.instance.currentUser!.uid,
              'Token': tokenId
            };
            serverList.add(data);
            print('subs token User Not Found SubScribed ');

            FirebaseFirestore.instance
                .collection('ArticleSubtype')
                .doc(value.docs.first.id)
                .update({'PeopleSubscribed': serverList});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('Error in Getting Device Id, SubScription Failed')));
          }
        });
      }
    });
  }

  getListData() async {
    pref = await SharedPreferences.getInstance();
    print('nnn l hii');
    FirebaseFirestore.instance
        .collection('ArticleSubtype')
        .orderBy('CreatedTime')
        .get()
        .then((value) async {
      value.docs.forEach((element) async {
        print('nnn subtype ads ${element.data()['SubType']}');
        list.add(TabData(
            index: int.parse(element.data()['Index']),
            photo: await element.data()['PhotoPath'],
            tab: Tab(
              icon: Container(
                width: context.screenWidth * 0.12,
                height: context.screenWidth * 0.12,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(context.screenWidth * 0.08),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            await element.data()['PhotoPath']),
                        fit: BoxFit.cover)),
              ),
              text: await element.data()['SubType'],
            )));
        print('nnnn list ${list.length}');
      });
    });
  }

  @override
  void initState() {
    getListData();

    getSharedPref();
    if (FirebaseAuth.instance.currentUser != null) {
      getFavouriteArticlesCategory();
    }

    scrollController.addListener(() async {
      if (scrollController.position.extentAfter == 0) {
        print('major  cu cakking get more products');
        context
            .read<LoaddatapartbypartCubit>()
            .getMoreProducts(listData!, lastDocData!, context, docLength!);
      }
    });

    context.read<LoaddatapartbypartCubit>().getProducts();
    versionControl();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('nnn builder build');
    final tabBarIndexCubit = BlocProvider.of<TabbarindexchangerCubit>(context);
    final favCategoryCubit = BlocProvider.of<FavouritecategoryCubit>(context);
    final favCategoryPrefCubit =
        BlocProvider.of<FavouritepreferenceCubit>(context);
    Future.delayed(Duration(seconds: 1), () {
      favCategoryPrefCubit.getFavCategoryFromPref(pref);
    });
    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 3000))
            .then((value) => Future.value(true)),
        builder: (context, snapshot) {
          print('nnn length list ${list.length}');
          _controller = TabController(length: list.length, vsync: this);
          print('nnn length list ${list.length}');
          return snapshot.hasData
              ? Scaffold(
                  /*appBar: AppBar(
                    elevation: 30,
                    leading: Builder(builder: (BuildContext context) {
                      return IconButton(
                        icon: Image.asset('images/fluenzologo.png'),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    }),
                    title: Text(
                      appName,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.bold),
                    ), //.shimmer(duration: 3.seconds),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                                create: (context) =>
                                                    ArticleCubit()),
                                            BlocProvider(
                                                create: (context) =>
                                                    SearchcubitCubit())
                                          ],
                                          child: SearchArticleScreen(),
                                        )));
                          },
                          icon: Icon(Icons.search))
                    ],
                  ),*/
                  body: BlocBuilder<TabbarindexchangerCubit,
                      TabbarindexchangerState>(builder: (context, tabState) {
                  print('nnn tab State ${tabState.tabIndex}');
                  _controller!.index = tabState.tabIndex!;
                  return Container(
                    width: context.screenWidth,
                    height: context.screenHeight * 0.9,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      5.heightBox,
                      BlocBuilder<ThemebasedwidgetCubit, ThemebasedwidgetState>(
                        builder: (context, wState) {
                          return SizedBox(
                            height: getWidth(context) * 0.3,
                            child: AppBar(
                                    leading: Container(),
                                    bottom: TabBar(
                                      //automaticIndicatorColorAdjustment: true,
                                      enableFeedback: true,
                                      unselectedLabelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      indicatorColor: Colors.blue,
                                      isScrollable: true,
                                      controller: _controller,
                                      tabs: list.map((e) {
                                        return InkWell(
                                            onDoubleTap: () {
                                              favCategoryPrefCubit
                                                  .getFavCategoryFromPref(pref);
                                              if (FirebaseAuth
                                                      .instance.currentUser !=
                                                  null) {
                                                //selecetedCategory.getSelectedCategory(snapshot.data.docs[index - 2]['SubType'].toString());
                                                // articleCubit.getDataForArticleSection(snapshot.data.docs[index - 2]['SubType'].toString());
                                                if (e.tab!.text != 'All' &&
                                                    e.tab!.text !=
                                                        'Favourites') {
                                                  FirebaseFirestore.instance
                                                      .collection('UserProfile')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .collection(
                                                          'UserFavouriteArticlesCategory')
                                                      .where('Category',
                                                          isEqualTo: e.tab!.text
                                                              .toString())
                                                      .get()
                                                      .then((value) async {
                                                    if (value.size != 0) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return ShowAlertDialogBoxWithYesNo(
                                                              alertType:
                                                                  'Alert..!',
                                                              alertMessage:
                                                                  'Category Already Added, Would You Like To Remove From Favourites?',
                                                              accept: () async {
                                                                removeCategoryBasedNotificationSubscription(e
                                                                    .tab!.text
                                                                    .toString());
                                                                favCategoryCubit
                                                                    .removeFavCategories(e
                                                                        .tab!
                                                                        .text
                                                                        .toString());
                                                                List<String>?
                                                                    favCat =
                                                                    await FavArticleSharedPreferences()
                                                                        .getFavCategories(
                                                                            pref);
                                                                favCat!.removeWhere(
                                                                    (element) =>
                                                                        element ==
                                                                        e.tab!
                                                                            .text
                                                                            .toString());
                                                                FavArticleSharedPreferences()
                                                                    .setFavCategories(
                                                                        favCat,
                                                                        pref);
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'UserProfile')
                                                                    .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                    .collection(
                                                                        'UserFavouriteArticlesCategory')
                                                                    .doc(value
                                                                        .docs
                                                                        .first
                                                                        .id)
                                                                    .delete()
                                                                    .whenComplete(() =>
                                                                        Navigator.pop(
                                                                            context));
                                                              },
                                                              decline: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            );
                                                          });
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return ShowAlertDialogBoxWithYesNo(
                                                              alertType:
                                                                  'Alert..!',
                                                              alertMessage:
                                                                  'Would You Like To Add This ${e.tab!.text.toString()} Category To Your Favourites?',
                                                              accept: () {
                                                                addCategoryBasedNotificationSubscription(e
                                                                    .tab!.text
                                                                    .toString());
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'UserProfile')
                                                                    .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                    .collection(
                                                                        'UserFavouriteArticlesCategory')
                                                                    .add({
                                                                  'Category': e
                                                                      .tab!.text
                                                                      .toString(),
                                                                  'CreatedAt':
                                                                      FieldValue
                                                                          .serverTimestamp()
                                                                }).whenComplete(() =>
                                                                        Navigator.pop(
                                                                            context));
                                                              },
                                                              decline: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            );
                                                          });
                                                    }
                                                  });
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return ShowAlertDialogBox(
                                                          alertMessage:
                                                              '${e.tab!.text} is Not A Subtype You Cannot Add into Favourites.',
                                                          alertType:
                                                              'Warning...!',
                                                        );
                                                      });
                                                }
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserNotLoggedInScreen()));
                                              }

                                              print('nnn double Tapped');
                                              tabBarIndexCubit
                                                  .getIndex(e.index!);
                                            },
                                            onTap: () {
                                              print('nnn single Tapped');
                                              tabBarIndexCubit
                                                  .getIndex(e.index!);
                                              favCategoryPrefCubit
                                                  .getFavCategoryFromPref(pref);
                                            },
                                            child: e.tab!);
                                      }).toList(),
                                    ))
                                .box
                                //          .margin(EdgeInsets.symmetric(horizontal: 10, vertical: 5))
                                .p12
                                .customRounded(
                                    BorderRadius.all(Radius.circular(15)))
                                .width(context.screenWidth)
                                .height(context.screenWidth * 0.35)
                                //.make();
                                .neumorphic(
                                  elevation: 30,
                                  color: wState.isLightTheme
                                      ? Colors.white
                                      : Colors.black,
                                )
                                .make(),
                          );
                        },
                      ),
                      10.heightBox,
                      Expanded(
                        child: TabBarView(
                          controller: _controller,
                          children: list.map((e) {
                            print('nnn tab working');
                            return BlocBuilder<LoaddatapartbypartCubit,
                                LoaddatapartbypartState>(
                              builder: (context, lState) {
                                print('major cubit building');
                                if (lState.lastDoc != null &&
                                    lState.splitedData != null &&
                                    lState.docLength != null) {
                                  lastDocData = lState.lastDoc;
                                  listData = lState.splitedData!;
                                  docLength = lState.docLength!;
                                }

                                return lState.splitedData != null
                                    ? e.tab!.text == 'Favourites'
                                        ? Container(
                                            padding: EdgeInsets.only(
                                              left: context.screenWidth * 0.025,
                                              right:
                                                  context.screenWidth * 0.025,
                                            ),
                                            //color: Colors.green,
                                            width: getWidth(context),
                                            height: getWidth(context) * 1.58,
                                            child:
                                                /* StreamBuilder(
                                                stream: state.articleStream,
                                                builder: (context,
                                                    AsyncSnapshot snapshot) {
                                                  return snapshot.hasData
                                                      ? snapshot.data!.docs
                                                                  .length ==
                                                              0
                                                          ? Center(
                                                              child: Text(
                                                                  'Content Not Available'))
                                                          : */
                                                ListView.builder(
                                                    controller:
                                                        scrollController,
                                                    shrinkWrap: true,
                                                    itemCount: lState
                                                        .splitedData!.length,
                                                    /*    snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length,*/
                                                    itemBuilder:
                                                        (context, index) {
                                                      /*   ArticlesModel
                                                                    model =
                                                                    ArticlesModel.fromJson(
                                                                        snapshot
                                                                            .data
                                                                            .docs[index]);*/
                                                      print('major check');
                                                      print(
                                                          'major check list ${lState.splitedData}');
                                                      print(
                                                          'major check ${lState.splitedData![index]['ArticleTitle']}');
                                                      ArticlesModel model =
                                                          ArticlesModel.fromJson(
                                                              lState.splitedData![
                                                                  index]);
                                                      print(
                                                          'major check in model ${model.articletitle}');
                                                      return BlocBuilder<
                                                              FavouritepreferenceCubit,
                                                              FavouritepreferenceState>(
                                                          builder: (context,
                                                              pFState) {
                                                        return BlocBuilder<
                                                            FavouritecategoryCubit,
                                                            FavouritecategoryState>(
                                                          builder: (context,
                                                              fState) {
                                                            if (fState
                                                                    .favCategory !=
                                                                null) {
                                                              FavArticleSharedPreferences()
                                                                  .setFavCategories(
                                                                      fState
                                                                          .favCategory!,
                                                                      pref);
                                                            }
                                                            /*Future.delayed(
                                                                Duration(
                                                                    seconds: 1),
                                                                () {
                                                              favCategoryPrefCubit
                                                                  .getFavCategoryFromPref(
                                                                      pref);
                                                            });*/
                                                            print(
                                                                'nnn fav bloc ${fState.favCategory} anf ${model.articleSubType}');
                                                            print(
                                                                'nnn fav shared ${pFState.locFavCategory}');
                                                            return fState.favCategory !=
                                                                        null &&
                                                                    pFState.locFavCategory !=
                                                                        null
                                                                ? fState.favCategory!.length !=
                                                                            0 ||
                                                                        pFState.locFavCategory!.length !=
                                                                            0
                                                                    //? fState.favCategory!.contains(snapshot.data.docs[index]['ArticleSubType']) || locFavCategory!.contains(snapshot.data.docs[index]['ArticleSubType'])
                                                                    ? fState.favCategory!.contains(model.articleSubType!) ||
                                                                            pFState.locFavCategory!.contains(model
                                                                                .articleSubType!)
                                                                        ? model.isArticlePublished ==
                                                                                "Published"
                                                                            ? RefreshIndicator(
                                                                                onRefresh:
                                                                                    () {
                                                                                  try {
                                                                                    context.read<LoaddatapartbypartCubit>().getProducts();
                                                                                  } catch (e) {
                                                                                    throw Exception(e);
                                                                                  }
                                                                                  return Future.delayed(Duration(milliseconds: 1500), () {
                                                                                    Future.value(true);
                                                                                  });
                                                                                },
                                                                                child:
                                                                                    InkWell(
                                                                                        onTap:
                                                                                            () {
                                                                                          Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                  builder: (context) => MultiBlocProvider(
                                                                                                        providers: [
                                                                                                          BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
                                                                                                          BlocProvider(create: (context) => ArticlelikeCubit()),
                                                                                                          BlocProvider(create: (context) => BookmarkCubit()),
                                                                                                          BlocProvider(create: (context) => ArticlesdetailCubit()),
                                                                                                          BlocProvider(create: (context) => ArticlelikeCubit()),
                                                                                                          BlocProvider(create: (context) => CheckuserloginedCubit()),
                                                                                                          BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
                                                                                                          BlocProvider(create: (context) => CommentStreamCubit()),
                                                                                                          BlocProvider(create: (context) => ArticletitleCubit()),
                                                                                                          BlocProvider(create: (context) => CommentnumbersCubit()),
                                                                                                          BlocProvider(create: (context) => ArticlereportCubit()),
                                                                                                          BlocProvider(create: (context) => BookmarkCubit())
                                                                                                        ],
                                                                                                        child: ArticlesDetailViewScreen(
                                                                                                          title: model.articletitle!,
                                                                                                          fromReviewOrReject: false,
                                                                                                          documentId: model.documentId!, //snapshot.data.docs[index].id,
                                                                                                          fromNotification: false,
                                                                                                          fromEdit: false,
                                                                                                        ),
                                                                                                      )));
                                                                                        },
                                                                                        child:
                                                                                            MultiBlocProvider(
                                                                                          providers: [
                                                                                            BlocProvider(
                                                                                              create: (context) => CheckuserloginedCubit(),
                                                                                            ),
                                                                                          ],
                                                                                          child: Column(
                                                                                            children: [
                                                                                              ArticleCard(
                                                                                                model: model,
                                                                                                docid: model.documentId!, //snapshot.data.docs[index].id,
                                                                                                title: model.articletitle!,
                                                                                                desc: model.articledesc!,
                                                                                              ),
                                                                                              30.heightBox
                                                                                              /* BlocBuilder<ThemebasedwidgetCubit, ThemebasedwidgetState>(
                                                                                                  builder: (context, wState) {
                                                                                                    return Divider(
                                                                                                      color: wState.isLightTheme ? Colors.white : Colors.black,
                                                                                                      thickness: 3,
                                                                                                    );
                                                                                                  },
                                                                                                )*/
                                                                                            ],
                                                                                          ),
                                                                                        )))
                                                                            : Container()
                                                                        : Container()
                                                                    /* "Double Tap On Categories To Add Into Favourites check1"
                                                                            .text
                                                                            .xl
                                                                            .center
                                                                            .bold
                                                                            .makeCentered()
                                                                            .box
                                                                            .px16
                                                                            .width(context
                                                                                .screenWidth)
                                                                            .height(context.screenHeight *
                                                                                0.75)
                                                                            .makeCentered()*/
                                                                    : index == 0
                                                                        ? "Double Tap On Categories To Add Into Favourites"
                                                                            .text
                                                                            .xl
                                                                            .center
                                                                            .bold
                                                                            .makeCentered()
                                                                            .box
                                                                            .px16
                                                                            .width(context
                                                                                .screenWidth)
                                                                            .height(context.screenHeight *
                                                                                0.75)
                                                                            .makeCentered()
                                                                        : Container()
                                                                : index == 0
                                                                    ? "Double Tap On Categories To Add Into Favourites"
                                                                        .text
                                                                        .xl
                                                                        .center
                                                                        .bold
                                                                        .makeCentered()
                                                                        .box
                                                                        .px16
                                                                        .width(
                                                                            context.screenWidth)
                                                                        .height(context.screenHeight * 0.75)
                                                                        .makeCentered()
                                                                    : Container();
                                                          },
                                                        );
                                                      });
                                                    })
                                            /*   : Center(
                                                          child: Column(
                                                              children: [
                                                              Text(
                                                                  'Article Data is Loading...')
                                                            ]));*/

                                            )
                                        : e.tab!.text == 'All'
                                            ? RefreshIndicator(
                                                onRefresh: () {
                                                  try {
                                                    context
                                                        .read<
                                                            LoaddatapartbypartCubit>()
                                                        .getProducts();
                                                  } catch (e) {
                                                    throw Exception(e);
                                                  }
                                                  return Future.delayed(
                                                      Duration(
                                                          milliseconds: 1500),
                                                      () {
                                                    Future.value(true);
                                                  });
                                                },
                                                child: Container(
                                                    //color: Colors.amber,
                                                    width: getWidth(context),
                                                    height: getWidth(context) *
                                                        1.58,
                                                    child:
                                                        /* StreamBuilder(
                                                      stream: state.articleStream,
                                                      builder: (context,
                                                          AsyncSnapshot
                                                              snapshot) {
                                                        return snapshot.hasData
                                                            ? snapshot.data!.docs
                                                                        .length ==
                                                                    0
                                                                ? Center(
                                                                    child: Text(
                                                                        'Content Not Available'))
                                                                : */
                                                        ListView.builder(
                                                            controller:
                                                                scrollController,
                                                            shrinkWrap: true,
                                                            itemCount: lState
                                                                .splitedData!
                                                                .length,
                                                            /*snapshot
                                                                            .data!
                                                                            .docs
                                                                            .length,*/
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              // ArticlesModel
                                                              //     model =
                                                              //     ArticlesModel.fromJson(snapshot.data.docs[index]);
                                                              ArticlesModel
                                                                  model =
                                                                  ArticlesModel
                                                                      .fromJson(
                                                                          lState
                                                                              .splitedData![index]);
                                                              //  ArticleModel2 model2 =
                                                              //    ArticleModel2.fromJson2(
                                                              //      snapshot.data.docs[index]);

                                                              // print(
                                                              //   'nnn model2 ${model2.timeStamp.toString()}');
                                                              // print(
                                                              //     'nnn fav categ ${favCategories.contains(model.articleSubType!)}');
                                                              return model.isArticlePublished ==
                                                                      "Published"
                                                                  ? e.tab!.text ==
                                                                          'All'
                                                                      ? Container(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            left:
                                                                                context.screenWidth * 0.025,
                                                                            right:
                                                                                context.screenWidth * 0.025,
                                                                          ),
                                                                          child: InkWell(
                                                                              onTap: () {
                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => MultiBlocProvider(
                                                                                              providers: [
                                                                                                BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
                                                                                                BlocProvider(create: (context) => ArticlelikeCubit()),
                                                                                                BlocProvider(create: (context) => BookmarkCubit()),
                                                                                                BlocProvider(create: (context) => ArticlesdetailCubit()),
                                                                                                BlocProvider(create: (context) => ArticlelikeCubit()),
                                                                                                BlocProvider(create: (context) => CheckuserloginedCubit()),
                                                                                                BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
                                                                                                BlocProvider(create: (context) => CommentStreamCubit()),
                                                                                                BlocProvider(create: (context) => ArticletitleCubit()),
                                                                                                BlocProvider(create: (context) => CommentnumbersCubit()),
                                                                                                BlocProvider(create: (context) => ArticlereportCubit()),
                                                                                                BlocProvider(create: (context) => BookmarkCubit())
                                                                                              ],
                                                                                              child: ArticlesDetailViewScreen(
                                                                                                title: model.articletitle!,
                                                                                                fromReviewOrReject: false,
                                                                                                documentId: model.documentId!, //snapshot.data.docs[index].id,
                                                                                                fromNotification: false,
                                                                                                fromEdit: false,
                                                                                              ),
                                                                                            )));
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  BlocProvider(
                                                                                    create: (context) => CheckuserloginedCubit(),
                                                                                    child: ArticleCard(
                                                                                      model: model,
                                                                                      docid: model.documentId!, //snapshot.data.docs[index].id,
                                                                                      title: model.articletitle!,
                                                                                      desc: model.articledesc!,
                                                                                    ),
                                                                                  ),
                                                                                  30.heightBox
                                                                                  /* Divider(
                                                                                    thickness: 3,
                                                                                  )*/
                                                                                ],
                                                                              )),
                                                                        )
                                                                      : Container() //Center(
                                                                  //child: Text(
                                                                  //   'Double Tap On The Category To Add Favourites'),
                                                                  // )
                                                                  : Container();
                                                              //Center(
                                                              // child: Text(
                                                              //   'Double Tap On The Category To Add Favourites'),
                                                              //        );
                                                            })
                                                    /*     : Center(
                                                                child: Column(
                                                                    children: [
                                                                    Text(
                                                                        'Article Data is Loading...'),
                                                                  ]));*/
                                                    // }),
                                                    ),
                                              )
                                            : RefreshIndicator(
                                                onRefresh: () {
                                                  try {
                                                    context
                                                        .read<
                                                            LoaddatapartbypartCubit>()
                                                        .getProducts();
                                                  } catch (e) {
                                                    throw Exception(e);
                                                  }
                                                  return Future.delayed(
                                                      Duration(
                                                          milliseconds: 1500),
                                                      () {
                                                    Future.value(true);
                                                  });
                                                },
                                                child: Container(
                                                    //color: Colors.amber,
                                                    width: getWidth(context),
                                                    height: getWidth(context) *
                                                        1.58,
                                                    child:
                                                        /* StreamBuilder(
                                                      stream: state.articleStream,
                                                      builder: (context,
                                                          AsyncSnapshot
                                                              snapshot) {
                                                        return snapshot.hasData
                                                            ? snapshot.data!.docs
                                                                        .length ==
                                                                    0
                                                                ? Center(
                                                                    child: Text(
                                                                        'Content Not Available'))
                                                                :*/
                                                        ListView.builder(
                                                            //physics:
                                                            //  PageScrollPhysics(),
                                                            controller:
                                                                scrollController,
                                                            shrinkWrap: true,
                                                            itemCount: lState
                                                                .splitedData!
                                                                .length,
                                                            /*snapshot
                                                                            .data!
                                                                            .docs
                                                                            .length,*/
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              // ArticlesModel
                                                              //     model =
                                                              //     ArticlesModel.fromJson(snapshot.data.docs[index]);
                                                              ArticlesModel
                                                                  model =
                                                                  ArticlesModel
                                                                      .fromJson(
                                                                          lState
                                                                              .splitedData![index]);
                                                              //  ArticleModel2 model2 =
                                                              //    ArticleModel2.fromJson2(
                                                              //      snapshot.data.docs[index]);

                                                              // print(
                                                              //   'nnn model2 ${model2.timeStamp.toString()}');

                                                              return model.isArticlePublished ==
                                                                      "Published"
                                                                  ?
                                                                  //  ? state.subType == snapshot.data.docs[index]['ArticleSubType']
                                                                  e.tab!.text ==
                                                                          model
                                                                              .articleSubType //snapshot.data.docs[index]['ArticleSubType']
                                                                      ? Container(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            left:
                                                                                context.screenWidth * 0.025,
                                                                            right:
                                                                                context.screenWidth * 0.025,
                                                                          ),
                                                                          child: InkWell(
                                                                              onTap: () {
                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => MultiBlocProvider(
                                                                                              providers: [
                                                                                                BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
                                                                                                BlocProvider(create: (context) => ArticlelikeCubit()),
                                                                                                BlocProvider(create: (context) => BookmarkCubit()),
                                                                                                BlocProvider(create: (context) => ArticlesdetailCubit()),
                                                                                                BlocProvider(create: (context) => ArticlelikeCubit()),
                                                                                                BlocProvider(create: (context) => CheckuserloginedCubit()),
                                                                                                BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
                                                                                                BlocProvider(create: (context) => CommentStreamCubit()),
                                                                                                BlocProvider(create: (context) => CommentnumbersCubit()),
                                                                                                BlocProvider(create: (context) => ArticletitleCubit()),
                                                                                                BlocProvider(
                                                                                                  create: (context) => ArticlereportCubit(),
                                                                                                ),
                                                                                                BlocProvider(create: (context) => BookmarkCubit()),
                                                                                              ],
                                                                                              child: ArticlesDetailViewScreen(
                                                                                                title: model.articletitle!,
                                                                                                fromReviewOrReject: false,
                                                                                                documentId: model.documentId!, //snapshot.data.docs[index].id,
                                                                                                fromNotification: false,
                                                                                                fromEdit: false,
                                                                                              ),
                                                                                            )));
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  BlocProvider(
                                                                                    create: (context) => CheckuserloginedCubit(),
                                                                                    child: ArticleCard(
                                                                                      model: model,
                                                                                      docid: model.documentId!, //snapshot.data.docs[index].id,
                                                                                      title: model.articletitle!,
                                                                                      desc: model.articledesc!,
                                                                                    ),
                                                                                  ),
                                                                                  30.heightBox
                                                                                  /* Divider(
                                                                                    thickness: 3,
                                                                                  )*/
                                                                                ],
                                                                              )),
                                                                        )
                                                                      : Container()
                                                                  : Container();
                                                              //                          : Container();
                                                            })
                                                    /*     : Center(
                                                                child: Column(
                                                                    children: [
                                                                    Text(
                                                                        'Article Data is Loading...'),
                                                                  ]));*/
                                                    // }),
                                                    ),
                                              )
                                    : Center(
                                        child: Text('Failed to Connect Server'),
                                      );

                                /*ListView.builder(
                                                                          shrinkWrap: true,
                                                                          itemCount:
                                                                              snapshot.data.docs.length,
                                                                          itemBuilder: (context, index) {
                                                                            ArticlesModel model =
                                                                                ArticlesModel.fromJson(
                                                                                    snapshot
                                                                                        .data.docs[index]);
                                                                            return InkWell(
                                                                                onTap: () {
                                                                                  Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                          builder: (context) =>
                                                                                              MultiBlocProvider(
                                                                                                providers: [
                                                                                                  BlocProvider(
                                                                                                      create: (context) =>
                                                                                                          ArticlesdetailCubit()),
                                                                                                  BlocProvider(
                                                                                                      create: (context) =>
                                                                                                          ArticlelikeCubit()),
                                                                                                  BlocProvider(
                                                                                                    create: (context) =>
                                                                                                        ArticlereportCubit(),
                                                                                                  ),
                                                                                                  BlocProvider(
                                                                                                      create: (context) =>
                                                                                                          CheckuserloginedCubit()),
                                                                                                  BlocProvider(
                                                                                                      create: (context) =>
                                                                                                          DetailviewdynamiclinkCubit()),
                                                                                                  BlocProvider(
                                                                                                      create: (context) =>
                                                                                                          CommentStreamCubit()),
                                                                                                  BlocProvider(
                                                                                                      create: (context) =>
                                                                                                          ArticletitleCubit()),
                                                                                                  BlocProvider(
                                                                                                      create: (context) =>
                                                                                                          BookmarkCubit()),
                                                                                                ],
                                                                                                child:
                                                                                                    ArticlesDetailViewScreen(
                                                                                                  fromReviewOrReject:
                                                                                                      false,
                                                                                                  documentId:
                                                                                                      snapshot
                                                                                                          .data
                                                                                                          .docs[index]
                                                                                                          .id,
                                                                                                  fromNotification:
                                                                                                      false,
                                                                                                  fromEdit:
                                                                                                      false,
                                                                                                ),
                                                                                              )));
                                                                                },
                                                                                child: model.articleSubType ==
                                                                                        e.tab!.text
                                                                                    ? BlocProvider(
                                                                                        create: (context) =>
                                                                                            CheckuserloginedCubit(),
                                                                                        child: Column(
                                                                                          children: [
                                                                                            ArticleCard(
                                                                                              model: model,
                                                                                              docid: snapshot
                                                                                                  .data
                                                                                                  .docs[index]
                                                                                                  .id,
                                                                                              title: model
                                                                                                  .articletitle!,
                                                                                              desc: model
                                                                                                  .articledesc!,
                                                                                            ),
                                                                                            5.heightBox,
                                                                                            Divider(
                                                                                              thickness: 3,
                                                                                            )
                                                                                          ],
                                                                                        ))
                                                                                    : Container());
                                                                          },
                                                                        );*/
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ]),
                  );
                }))
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        });
  }
}

class TabData {
  Tab? tab;
  int? index;
  String? photo;

  TabData({this.tab, this.photo, this.index});
}

//import 'package:flutter/material.dart';

class TabBarDemo extends StatefulWidget {
  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(icon: Icon(Icons.card_travel)),
    Tab(icon: Icon(Icons.add_shopping_cart)),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
      print("Selected Index: " + _controller!.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Center(
                child: Text(
              _selectedIndex.toString(),
              style: TextStyle(fontSize: 40),
            )),
            Center(
                child: Text(
              _controller!.index.toString(),
              //_selectedIndex.toString(),
              style: TextStyle(fontSize: 40),
            )),
          ],
        ),
      ),
    );
  }
}
 */