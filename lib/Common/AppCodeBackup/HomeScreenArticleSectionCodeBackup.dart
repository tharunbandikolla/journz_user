/* import 'package:Journz/Common/Helper/FavouriteSelectionDialogCubit/favouriteselectiondialogbox_cubit.dart';
import 'package:Journz/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import 'package:Journz/Common/Widgets/AppDrawer.dart';
import 'package:Journz/Common/Widgets/FavCategoryButton.dart';
import 'package:Journz/HomeScreen/Bloc/FavouritePreferencesCubit/favouritepreference_cubit.dart';
import 'package:Journz/HomeScreen/DataModel/ArticlesSubtypeModel.dart';
import 'package:Journz/HomeScreen/Helper/LocalSubTypeListPref.dart';
import 'package:Journz/SearchArticles/Cubit/cubit/searchcubit_cubit.dart';
import 'package:Journz/SearchArticles/Screen/SearchArticlesScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentNumbers/commentnumbers_cubit.dart';
import '/Common/Helper/LoadDataPartByPartCubit/loaddatapartbypart_cubit.dart';
import '/Common/Widgets/AlertDialogBoxWidget.dart';
import '/HomeScreen/Bloc/FavouriteCategoryCubit/favouritecategory_cubit.dart';
import '/HomeScreen/Bloc/SelectedCategoryCubit/selectedcategory_cubit.dart';
import '/HomeScreen/Helper/FavArticleSharedPreferences.dart';
import '/UserProfile/Screen/UserNotLoggedInScreen.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreenArticleSection extends StatefulWidget {
  HomeScreenArticleSection({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenArticleSectionState createState() =>
      _HomeScreenArticleSectionState();
}

class _HomeScreenArticleSectionState extends State<HomeScreenArticleSection> {
  var postId;
  ScrollController scrollController = new ScrollController();

  int docLength = 0;

  DocumentSnapshot? lastDocData;

  List<DocumentSnapshot<Object?>> list = [];

  @override
  void initState() {
    getSharedPref();
    /*  if (FirebaseAuth.instance.currentUser != null) {
      getFavouriteArticlesCategory();
    } */
    getCurrentSubTypeList();
    favouriteCategoryByUser();
    scrollController.addListener(() async {
      if (scrollController.position.extentAfter == 0) {
        print('major cakking get more products');
        context
            .read<LoaddatapartbypartCubit>()
            .getMoreProducts(list, lastDocData!, context, docLength);
      }
    });

    context.read<LoaddatapartbypartCubit>().getProducts();
    versionControl();
    super.initState();
  }

  var appUserName;
  var msgUpdate;
  var checkMobileNumberLinked;
  var versionNo, versionNumberFromServer, updateType;
  List<dynamic> currentSubTypeList = [];
  List<String>? localSubTypeList = [];

  getCurrentSubTypeList() async {
    FirebaseFirestore.instance
        .collection('ArticleSubtype')
        .get()
        .then((value) async {
      value.docs.forEach((element) async {
        if (await element.data()['NoOfArticles'] > 0) {
          currentSubTypeList.add(ArticlesSubtypeModel(
              subTypeName: await element.data()['SubType'],
              photoUrl: await element.data()['PhotoPath']));
          print('nnn current list ${currentSubTypeList[0].photoUrl}');
        }
      });
    });
  }

  List<dynamic> userFavouriteCategoryListFromDB = [];
  favouriteCategoryByUser() async {
    FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      userFavouriteCategoryListFromDB =
          await value.data()!['UsersFavouriteArticleCategory'];
    });
  }

  showFavouritesCategoryDialog() async {
    print('localS entered');
    List<String> locListForPref = [];
    // LocalArticleCAtegorySharedPreferences().setLocalCategories([], pref);
    localSubTypeList =
        await LocalArticleCAtegorySharedPreferences().getLocalCategories(pref);
    LocalArticleCAtegorySharedPreferences().setLocalCategories([], pref);
    //if (localSubTypeList != []) {
    if (localSubTypeList!.length != currentSubTypeList.length) {
      for (var i in currentSubTypeList) {
        locListForPref.add(i.subTypeName.toString());
        LocalArticleCAtegorySharedPreferences()
            .setLocalCategories(locListForPref, pref);
      }
      //LocalArticleCAtegorySharedPreferences().setLocalCategories([], pref);
    }

    Future.delayed(Duration(seconds: 5), () async {
      calbk(List<dynamic> abc) {
        userFavouriteCategoryListFromDB = abc;
        print('nnn new callback $userFavouriteCategoryListFromDB');
      }

      print(
          'localSubType ${await LocalArticleCAtegorySharedPreferences().getLocalCategories(pref)}');
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
                //backgroundColor: Colors.transparent,
                title: Text('Add Favourites'),
                content: Column(
                  children: [
                    GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                    crossAxisCount: 3),
                            itemCount: currentSubTypeList.length,
                            itemBuilder: (context, index) {
                              return BlocProvider(
                                create: (context) =>
                                    FavouriteselectiondialogboxCubit(),
                                child: FavCategoryButton(
                                    callback: calbk,
                                    photoUrl:
                                        currentSubTypeList[index].photoUrl,
                                    category:
                                        currentSubTypeList[index].subTypeName,
                                    favCategory:
                                        currentSubTypeList[index].subTypeName,
                                    favCategoryList:
                                        userFavouriteCategoryListFromDB),
                              );
                            })
                        .box
                        .width(context.screenWidth)
                        .height(context.screenWidth * 0.75)
                        .make(),
                    15.heightBox,
                    ElevatedButton(
                        onPressed: () async {
                          List<String> listForPref = [];
                          print(
                              'nnn new Done $userFavouriteCategoryListFromDB');
                          for (var o in userFavouriteCategoryListFromDB) {
                            listForPref.add(o.toString());
                            FavArticleSharedPreferences()
                                .setFavCategories(listForPref, pref);
                          }

                          FirebaseFirestore.instance
                              .collection('UserProfile')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'UsersFavouriteArticleCategory':
                                userFavouriteCategoryListFromDB
                          }); //.then((value) {
                          for (ArticlesSubtypeModel i in currentSubTypeList) {
                            if (userFavouriteCategoryListFromDB
                                .contains(i.subTypeName)) {
                              FirebaseFirestore.instance
                                  .collection('ArticleSubtype')
                                  .where('SubType', isEqualTo: i.subTypeName)
                                  .get()
                                  .then((value) {
                                if (value.size != 0) {
                                  print('nnn new val cominfg');
                                  FirebaseFirestore.instance
                                      .collection('ArticleSubtype')
                                      .doc(value.docs.first.id)
                                      .get()
                                      .then((val) async {
                                    List<dynamic> help =
                                        await val.data()!['PeopleSubscribed'];
                                    if (!help.contains(tokenId)) {
                                      help.add(tokenId);
                                      FirebaseFirestore.instance
                                          .collection('ArticleSubtype')
                                          .doc(value.docs.first.id)
                                          .update({'PeopleSubscribed': help});
                                    }
                                  });
                                }
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection('ArticleSubtype')
                                  .where('SubType', isEqualTo: i.subTypeName)
                                  .get()
                                  .then((value) {
                                if (value.size != 0) {
                                  print('nnn new val cominfg');
                                  FirebaseFirestore.instance
                                      .collection('ArticleSubtype')
                                      .doc(value.docs.first.id)
                                      .get()
                                      .then((val) async {
                                    List<dynamic> help =
                                        await val.data()!['PeopleSubscribed'];
                                    if (help.contains(tokenId)) {
                                      help.remove(tokenId);
                                      FirebaseFirestore.instance
                                          .collection('ArticleSubtype')
                                          .doc(value.docs.first.id)
                                          .update({'PeopleSubscribed': help});
                                    }
                                  });
                                }
                              });
                            }
                          }
                          //});
                        },
                        child: Text('Done'))
                  ],
                )
                    .box
                    .width(context.screenWidth)
                    .height(context.screenWidth)
                    .make());
          });
    });

    /* } else {
      print('object nnn');
      LocalArticleCAtegorySharedPreferences().setLocalCategories([], pref);
    } */
  }

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
              context: context,
              builder: (context) {
                return WillPopScope(
                  onWillPop: () {
                    return Future.value(false);
                  },
                  child:
                      BlocBuilder<ThemebasedwidgetCubit, ThemebasedwidgetState>(
                    builder: (context, wState) {
                      return Container(
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
                                /* .neumorphic(
                                    color: wState.isLightTheme
                                        ? Colors.white
                                        : Colors.black,
                                    elevation: 30) */
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
                                        /* .neumorphic(
                                            color: Colors.black, elevation: 30) */
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
                                        child: "Ignore"
                                            .text
                                            .xl
                                            .bold
                                            .makeCentered())
                                    : Container(),
                                ElevatedButton(
                                    onPressed: () {
                                      launch('https://play.google.com/store/apps/details?id=in.journz.journz')
                                          .then((value) =>
                                              Navigator.pop(context));
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
                      );
                    },
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

  var tokenId;
  var pref;
  getSharedPref() async {
    pref = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection('UserProfile')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        checkMobileNumberLinked = await value.data()!['IsMobileNumberVerified'];

        print('nnnn daata $checkMobileNumberLinked');
      });
    }
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    tokenId = await messaging.getToken();
  }

  String? userRole;

  /* List<dynamic> favCategories = [];
  getFavouriteArticlesCategory() async {
    context.read<FavouritecategoryCubit>().getFavCategories();
  } */

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

  @override
  Widget build(BuildContext context) {
    final articleCubit = BlocProvider.of<ArticleCubit>(context);
    final selecetedCategory = BlocProvider.of<SelectedcategoryCubit>(context);
    final favCategoryCubit = BlocProvider.of<FavouritecategoryCubit>(context);
    final favCategoryPrefCubit =
        BlocProvider.of<FavouritepreferenceCubit>(context);

    return Scaffold(
      appBar: AppBar(
        //systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 12,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Image.asset('images/fluenzologo.png'),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        title: Text(
          appName,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showFavouritesCategoryDialog();
              },
              icon: Icon(Icons.add_task)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                    create: (context) => ArticleCubit()),
                                BlocProvider(
                                    create: (context) => SearchcubitCubit())
                              ],
                              child: SearchArticleScreen(),
                            )));
              },
              icon: Icon(Icons.search))
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 3))
              .then((value) => Future.value(true)),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Container(
                    height: getHeight(context) * 0.98,
                    width: getWidth(context),
                    margin: EdgeInsets.symmetric(
                        horizontal: getWidth(context) * 0.015),
                    child: BlocBuilder<SelectedcategoryCubit,
                        SelectedcategoryState>(
                      builder: (context, selectedState) {
                        return BlocBuilder<ThemebasedwidgetCubit,
                            ThemebasedwidgetState>(
                          builder: (context, wState) {
                            return Container(
                                child: Column(
                              children: [
                                5.heightBox,
                                /*BlocBuilder<ArticleCubit, ArticleState>(
                                    builder: (context, state) {
                                  return 
                                      StreamBuilder(
                                              stream: state.articleSubtype,
                                              builder: (context,
                                                  AsyncSnapshot snapshot) {
                                                return snapshot.hasData
                                                    ? snapshot.data!.docs
                                                                .length ==
                                                            0
                                                        ? Center(
                                                            child: Text(
                                                                'Awesome Articles On The Way'))
                                                        : */
                                ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: currentSubTypeList
                                                .length /* snapshot
                                                                    .data!
                                                                    .docs
                                                                    .length */
                                            +
                                            2,
                                        itemBuilder: (context, index) {
                                          return index == 1
                                              ? Container(
                                                  width:
                                                      getWidth(context) * 0.2,
                                                  height:
                                                      getWidth(context) * 0.1,
                                                  margin: EdgeInsets.all(
                                                      getWidth(context) *
                                                          0.001),
                                                  child: InkWell(
                                                    /* onDoubleTap: () {
                                                      favCategoryPrefCubit
                                                          .getFavCategoryFromPref(
                                                              pref);
                                                      selecetedCategory
                                                          .getSelectedCategory(
                                                              'Favourites');
                                                      articleCubit
                                                          .getDataForArticleSection(
                                                              'Favourites');
                                                      if (FirebaseAuth.instance
                                                              .currentUser ==
                                                          null) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        UserNotLoggedInScreen()));
                                                      }
                                                    }, */
                                                    onTap: () {
                                                      // showFavouritesCategoryDialog();

                                                      /*favCategoryPrefCubit
                                                          .getFavCategoryFromPref(
                                                              pref);*/
                                                      selecetedCategory
                                                          .getSelectedCategory(
                                                              'Favourites');
                                                      /* articleCubit
                                                          .getDataForArticleSection(
                                                              'Favourites'); */
                                                    },
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          BlocBuilder<
                                                              SelectedcategoryCubit,
                                                              SelectedcategoryState>(
                                                            builder: (context,
                                                                sState) {
                                                              print(
                                                                  'nnnn selected Ctaegory ${sState.selectedCategory}');
                                                              return Container(
                                                                width: getWidth(
                                                                        context) *
                                                                    0.14,
                                                                height: getWidth(
                                                                        context) *
                                                                    0.14,
                                                                decoration: BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          spreadRadius:
                                                                              1.5,
                                                                          color: sState.selectedCategory! == 'Favourites'
                                                                              ? Colors.blue
                                                                              : Colors.black)
                                                                    ],
                                                                    image: DecorationImage(
                                                                        image: NetworkImage('https://picsum.photos/300')
                                                                        /* NetworkImage(
                                                                                                                                                                                                                                  'https://picsum.photos/200'),*/
                                                                        ,
                                                                        fit: BoxFit.fill),
                                                                    borderRadius: BorderRadius.circular(getWidth(context) * 0.1)),
                                                              );
                                                            },
                                                          ),
                                                          Container(
                                                            child: Text(
                                                                'Favourites',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : index == 0
                                                  ? Container(
                                                      width: getWidth(context) *
                                                          0.2,
                                                      height:
                                                          getWidth(context) *
                                                              0.1,
                                                      margin: EdgeInsets.all(
                                                          getWidth(context) *
                                                              0.001),
                                                      child: InkWell(
                                                        /* onDoubleTap: () {
                                                          favCategoryPrefCubit
                                                              .getFavCategoryFromPref(
                                                                  pref);
                                                          selecetedCategory
                                                              .getSelectedCategory(
                                                                  'All');
                                                          articleCubit
                                                              .getDataForArticleSection(
                                                                  'All');
                                                          if (FirebaseAuth
                                                                  .instance
                                                                  .currentUser ==
                                                              null) {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            UserNotLoggedInScreen()));
                                                          }
                                                        }, */
                                                        onTap: () {
                                                          /*  favCategoryPrefCubit
                                                              .getFavCategoryFromPref(
                                                                  pref);
                                                          */
                                                          selecetedCategory
                                                              .getSelectedCategory(
                                                                  'All');
                                                          articleCubit
                                                              .getDataForArticleSection(
                                                                  'All');
                                                        },
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              BlocBuilder<
                                                                  SelectedcategoryCubit,
                                                                  SelectedcategoryState>(
                                                                builder:
                                                                    (context,
                                                                        sState) {
                                                                  return Container(
                                                                    width: getWidth(
                                                                            context) *
                                                                        0.14,
                                                                    height: getWidth(
                                                                            context) *
                                                                        0.14,
                                                                    decoration: BoxDecoration(
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              spreadRadius: 1.5,
                                                                              color: sState.selectedCategory! == 'All' ? Colors.blue : Colors.black)
                                                                        ],
                                                                        image: DecorationImage(
                                                                            image: NetworkImage('https://picsum.photos/200')
                                                                            /* NetworkImage(
                                                                                                                                                                                                                                      'https://picsum.photos/200'),*/
                                                                            ,
                                                                            fit: BoxFit.fill),
                                                                        borderRadius: BorderRadius.circular(getWidth(context) * 0.1)),
                                                                  );
                                                                },
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                    'All',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: getWidth(context) *
                                                          0.2,
                                                      height:
                                                          getWidth(context) *
                                                              0.1,
                                                      margin: EdgeInsets.all(
                                                          getWidth(context) *
                                                              0.005),
                                                      child: InkWell(
                                                        /*  onDoubleTap: () {
                                                          favCategoryPrefCubit
                                                              .getFavCategoryFromPref(
                                                                  pref);
                                                          if (FirebaseAuth
                                                                  .instance
                                                                  .currentUser !=
                                                              null) {
                                                            selecetedCategory.getSelectedCategory(
                                                                currentSubTypeList[
                                                                        index -
                                                                            2]
                                                                    .subTypeName
                                                                    .toString());
                                                            articleCubit.getDataForArticleSection(
                                                                currentSubTypeList[
                                                                        index -
                                                                            2]
                                                                    .subTypeName
                                                                    .toString());
                                                          }

                                                          /* FirebaseFirestore.instance.collection('UserProfile').doc(FirebaseAuth.instance.currentUser!.uid).collection('UserFavouriteArticlesCategory').where('Category', isEqualTo: snapshot.data.docs[index - 2]['SubType'].toString()).get().then((value) async {
                                                                                      if (value.size != 0) {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (context) {
                                                                                              return ShowAlertDialogBoxWithYesNo(
                                                                                                alertType: 'Alert..!',
                                                                                                alertMessage: 'Category Already Added, Would You Like To Remove From Favourites?',
                                                                                                accept: () async {
                                                                                                  removeCategoryBasedNotificationSubscription(snapshot.data.docs[index - 2]['SubType'].toString());
                                                                                                  favCategoryCubit.removeFavCategories(snapshot.data.docs[index - 2]['SubType'].toString());
                                                                                                  List<String>? favCat = await FavArticleSharedPreferences().getFavCategories(pref);
                                                                                                  favCat!.removeWhere((element) => element == snapshot.data.docs[index - 2]['SubType'].toString());
                                                                                                  FavArticleSharedPreferences().setFavCategories(favCat, pref);
                                                                                                  FirebaseFirestore.instance.collection('UserProfile').doc(FirebaseAuth.instance.currentUser!.uid).collection('UserFavouriteArticlesCategory').doc(value.docs.first.id).delete().whenComplete(() => Navigator.pop(context));
                                                                                                },
                                                                                                decline: () {
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                              );
                                                                                            });
                                                                                      } else {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (context) {
                                                                                              return ShowAlertDialogBoxWithYesNo(
                                                                                                alertType: 'Alert..!',
                                                                                                alertMessage: 'Would You Like To Add This ${snapshot.data.docs[index - 2]['SubType'].toString()} Category To Your Favourites?',
                                                                                                accept: () {
                                                                                                  addCategoryBasedNotificationSubscription(snapshot.data.docs[index - 2]['SubType'].toString());
                                                                                                  FirebaseFirestore.instance.collection('UserProfile').doc(FirebaseAuth.instance.currentUser!.uid).collection('UserFavouriteArticlesCategory').add({
                                                                                                    'Category': snapshot.data.docs[index - 2]['SubType'].toString(),
                                                                                                    'CreatedAt': FieldValue.serverTimestamp()
                                                                                                  }).whenComplete(() => Navigator.pop(context));
                                                                                                },
                                                                                                decline: () {
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                              );
                                                                                            });
                                                                                      }
                                                                                    });
                                                                                  } else {
                                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserNotLoggedInScreen()));
                                                                                  }

                                                                                  print('nnn double Tapped'); */
                                                        },
                                                        */
                                                        onTap: () {
                                                          favCategoryPrefCubit
                                                              .getFavCategoryFromPref(
                                                                  pref);
                                                          selecetedCategory
                                                              .getSelectedCategory(
                                                                  currentSubTypeList[
                                                                          index -
                                                                              2]
                                                                      .subTypeName
                                                                      .toString());
                                                          articleCubit.getDataForArticleSection(
                                                              currentSubTypeList[
                                                                      index - 2]
                                                                  .subTypeName
                                                                  .toString());
                                                        },
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              /*  Card(
                                                                                                                                                  elevation: 12,
                                                                                                                                                  child:*/
                                                              BlocBuilder<
                                                                  SelectedcategoryCubit,
                                                                  SelectedcategoryState>(
                                                                builder:
                                                                    (context,
                                                                        sState) {
                                                                  return Container(
                                                                    width: getWidth(
                                                                            context) *
                                                                        0.14,
                                                                    height: getWidth(
                                                                            context) *
                                                                        0.14,
                                                                    decoration: BoxDecoration(
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              spreadRadius: 1.5,
                                                                              color: sState.selectedCategory! == currentSubTypeList[index - 2].subTypeName.toString() ? Colors.blue : Colors.black)
                                                                        ],
                                                                        image: DecorationImage(
                                                                            image: NetworkImage(currentSubTypeList[index - 2]
                                                                                .photoUrl
                                                                                .toString()),
                                                                            fit: BoxFit
                                                                                .fill),
                                                                        borderRadius:
                                                                            BorderRadius.circular(getWidth(context) *
                                                                                0.1)),
                                                                  );
                                                                },
                                                              ),
                                                              /*),*/
                                                              Text(
                                                                  currentSubTypeList[
                                                                          index -
                                                                              2]
                                                                      .subTypeName
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                        })
                                    .box
                                    .customRounded(BorderRadius.circular(20))
                                    .width(context.screenWidth * 0.9)
                                    .height(context.screenWidth * 0.275)
                                    .p12
                                    .margin(EdgeInsets.all(
                                        context.screenWidth * 0.013))
                                    .neumorphic(
                                        color: wState.isLightTheme
                                            ? Colors.white
                                            : Colors.black,
                                        elevation: 30)
                                    .make()
                                /*    : Center(
                                                        child: Column(
                                                            children: [
                                                            Text(
                                                                'Article Data is Loading...')
                                                          ]) */ //);
                                //}
                                /*)),*/

/*                                           
 */ //      }),
                                /* },
                                    );
                                  },
                                ), */
                                ,
                                5.heightBox,
                                /*  Divider(
                                                      thickness: 3,
                                                    ),*/
                                BlocBuilder<LoaddatapartbypartCubit,
                                    LoaddatapartbypartState>(
                                  builder: (context, lState) {
                                    print('major cubit building');
                                    if (lState.lastDoc != null &&
                                        lState.splitedData != null &&
                                        lState.docLength != null) {
                                      lastDocData = lState.lastDoc;
                                      list = lState.splitedData!;
                                      docLength = lState.docLength!;
                                    }
                                    /*  print(
                                        'nnn selected subtype ${state.subType}'); */
                                    return lState.splitedData != null
                                        ? selectedState.selectedCategory ==
                                                'Favourites'
                                            ? Container(
                                                color: Colors.green,
                                                width: getWidth(context),
                                                height:
                                                    getWidth(context) * 1.52,
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
                                                            .splitedData!
                                                            .length,
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
                                                              ArticlesModel
                                                                  .fromJson(lState
                                                                          .splitedData![
                                                                      index]);
                                                          print(
                                                              'major check in model ${model.articletitle}');
                                                          return BlocBuilder<
                                                              FavouritepreferenceCubit,
                                                              FavouritepreferenceState>(
                                                            builder: (context,
                                                                pFState) {
                                                              print(
                                                                  'nnn pref ${pFState.locFavCategory}');
                                                              return pFState
                                                                      .locFavCategory!
                                                                      .contains(
                                                                          model
                                                                              .articleSubType)
                                                                  ?

                                                                  /* BlocBuilder<
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
                                                                    'nnn fav shared ${pFState.locFavCategory}'); */
                                                                  /* return */ /* fState.favCategory !=
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
                                                                            ? */
                                                                  model.isArticlePublished ==
                                                                          "Published"
                                                                      ? RefreshIndicator(
                                                                          onRefresh:
                                                                              () {
                                                                            try {
                                                                              context.read<LoaddatapartbypartCubit>().getProducts();
                                                                            } catch (e) {
                                                                              throw Exception(e);
                                                                            }
                                                                            return Future.delayed(Duration(milliseconds: 1500),
                                                                                () {
                                                                              Future.value(true);
                                                                            });
                                                                          },
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
                                                                                                checkMobileNumberLinked: checkMobileNumberLinked,
                                                                                                title: model.articletitle!,
                                                                                                fromReviewOrReject: false,
                                                                                                documentId: model.documentId!, //snapshot.data.docs[index].id,
                                                                                                fromNotification: false,
                                                                                                fromEdit: false,
                                                                                              ),
                                                                                            )));
                                                                              },
                                                                              child: BlocProvider(
                                                                                create: (context) => CheckuserloginedCubit(),
                                                                                child: Column(
                                                                                  children: [
                                                                                    ArticleCard(
                                                                                      model: model,
                                                                                      docid: model.documentId!, //snapshot.data.docs[index].id,
                                                                                      title: model.articletitle!,
                                                                                      desc: model.articledesc!,
                                                                                    ).box.margin(EdgeInsets.symmetric(horizontal: context.screenWidth * 0.025)).make(),
                                                                                    13.heightBox
                                                                                  ],
                                                                                ),
                                                                              )),
                                                                        )
                                                                      : Container()
                                                                  : Container();
                                                              //: Container()
                                                              /* /* "Double Tap On Categories To Add Into Favourites check1"
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
                                                                        : index ==
                                                                                0
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
                                                                            .width(context.screenWidth)
                                                                            .height(context.screenHeight * 0.75)
                                                                            .makeCentered()
                                                                        : Container(); */
                                                            },
                                                          );
                                                          //});
                                                        })
                                                /*   : Center(
                                                                                  child: Column(
                                                                                      children: [
                                                                                      Text(
                                                                                          'Article Data is Loading...')
                                                                                    ]));*/

                                                )
                                            : selectedState.selectedCategory ==
                                                    'All'
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
                                                              milliseconds:
                                                                  1500), () {
                                                        Future.value(true);
                                                      });
                                                    },
                                                    child: Container(
                                                        //color: Colors.amber,
                                                        width:
                                                            getWidth(context),
                                                        height:
                                                            getWidth(context) *
                                                                1.52,
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
                                                                shrinkWrap:
                                                                    true,
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
                                                                      ArticlesModel.fromJson(
                                                                          lState
                                                                              .splitedData![index]);
                                                                  //  ArticleModel2 model2 =
                                                                  //    ArticleModel2.fromJson2(
                                                                  //      snapshot.data.docs[index]);

                                                                  // print(
                                                                  //   'nnn model2 ${model2.timeStamp.toString()}');
                                                                  /*  print(
                                                                      'nnn fav categ ${favCategories.contains(model.articleSubType!)}'); */
                                                                  return model.isArticlePublished ==
                                                                          "Published"
                                                                      ? selectedState.selectedCategory ==
                                                                              'All'
                                                                          ? InkWell(
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
                                                                                                checkMobileNumberLinked: checkMobileNumberLinked,
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
                                                                                    ).box.margin(EdgeInsets.symmetric(horizontal: context.screenWidth * 0.025)).make(),
                                                                                  ),
                                                                                  /*                          Divider(
                                                                                                        thickness: 3,
                                                                                                      )*/
                                                                                  13.heightBox
                                                                                ],
                                                                              ))
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
                                                              milliseconds:
                                                                  1500), () {
                                                        Future.value(true);
                                                      });
                                                    },
                                                    child: Container(
                                                        //color: Colors.amber,
                                                        width:
                                                            getWidth(context),
                                                        height:
                                                            getWidth(context) *
                                                                1.52,
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
                                                                shrinkWrap:
                                                                    true,
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
                                                                      ArticlesModel.fromJson(
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
                                                                      selectedState.selectedCategory ==
                                                                              model.articleSubType //snapshot.data.docs[index]['ArticleSubType']
                                                                          ? InkWell(
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
                                                                                    ).box.margin(EdgeInsets.symmetric(horizontal: context.screenWidth * 0.025)).make(),
                                                                                  ),
                                                                                  13.heightBox
                                                                                  /*                      Divider(
                                                                                                        thickness: 3,
                                                                                                      )*/
                                                                                ],
                                                                              ))
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
                                            child: Text('No Data'),
                                          );
                                  },
                                ),
                              ],
                            ));
                          },
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text('Loading...'),
                  );
          }),
      /*bottomSheet: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('JournzAppVersion')
            .orderBy('CreatedTime', descending: true)
            .get(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? versionNumberFromServer == versionNo
                            ? Container(height: 0)
                            : Container(
                                height: 400,
                                width: context.screenWidth,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('close'),
                                ),
                              )
                        : Container();
                  },
                )
              : Container();
        },
      ),*/
    );
  }
}

/*      Card(
                  child: Container(
                    width: getWidth(context),
                    height: getWidth(context) * 0.15,
                    child: StreamBuilder(
                        stream: state.articleSubtype,
                        builder: (context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return index == 0
                                        ? Container(
                                            
                                            child: TextButton(
                                            onPressed: () {
                                              articleCubit
                                                  .getDataForArticleSection(
                                                      'All');
                                            },
                                            child: Text('All',
                                                style: TextStyle(

                                                    )),
                                          ))
                                        : Container(
                                            
                                            child: TextButton(
                                            onPressed: () {
                                              articleCubit
                                                  .getDataForArticleSection(
                                                      snapshot
                                                          .data
                                                          .docs[index - 1]
                                                              ['SubType']
                                                          .toString());
                                            },
                                            child: Text(
                                                snapshot.data
                                                    .docs[index - 1]['SubType']
                                                    .toString(),
                                                style: TextStyle(
                                                    
                                                    )),
                                          ));
                                  })
                              : Center(
                                  child: Column(children: [
                                  Text('Article Data is Loading...')
                                ]));
                        }),
                  ),
                )
          
 */





 */