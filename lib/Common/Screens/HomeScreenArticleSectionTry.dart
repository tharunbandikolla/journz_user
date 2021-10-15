import 'package:Journz/ArticleDetailView/ArticlesDetailViewCubit/StaticArticleLikeCubit/staticarticlelike_cubit.dart';
import 'package:Journz/ArticleDetailView/Screen/ArticleDetailViewScreenNew.dart';
import 'package:Journz/Common/Helper/BannerAdHelper.dart';
import 'package:Journz/Common/Helper/FavouriteSelectionDialogCubit/favouriteselectiondialogbox_cubit.dart';
import 'package:Journz/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import 'package:Journz/Common/Widgets/AppDrawer.dart';
import 'package:Journz/Common/Widgets/FavCategoryButton.dart';
import 'package:Journz/HomeScreen/Bloc/FavouritePreferencesCubit/favouritepreference_cubit.dart';
import 'package:Journz/HomeScreen/DataModel/ArticlesSubtypeModel.dart';
import 'package:Journz/HomeScreen/Helper/LocalSubTypeListPref.dart';
import 'package:Journz/SearchArticles/Cubit/cubit/searchcubit_cubit.dart';
import 'package:Journz/SearchArticles/Screen/SearchArticlesScreen.dart';
import 'package:Journz/UserProfile/Screen/UserNotLoggedInScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentNumbers/commentnumbers_cubit.dart';
import '/Common/Helper/LoadDataPartByPartCubit/loaddatapartbypart_cubit.dart';
import '/HomeScreen/Bloc/SelectedCategoryCubit/selectedcategory_cubit.dart';
import '/HomeScreen/Helper/FavArticleSharedPreferences.dart';
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

class HomeScreenArticleSectionTry extends StatefulWidget {
  List<DocumentSnapshot>? articlesList;
  List<dynamic>? subtypeList;
  List<dynamic>? favCatgoryList;
  HomeScreenArticleSectionTry(
      {Key? key, this.articlesList, this.subtypeList, this.favCatgoryList})
      : super(key: key);

  @override
  _HomeScreenArticleSectionTryState createState() =>
      _HomeScreenArticleSectionTryState();
}

class _HomeScreenArticleSectionTryState
    extends State<HomeScreenArticleSectionTry> {
  var postId;
  ScrollController scrollController = new ScrollController();

  int docLength = 0;

  DocumentSnapshot? lastDocData;

  List<DocumentSnapshot<Object?>> list = [];
  List<dynamic> userFavouriteCategoryListFromDB = [];
  List<dynamic> dataWithAds = [];
  @override
  void initState() {
    getSharedPref();
    print('nnn fav cate ${widget.favCatgoryList}');
    //versionControl();
    currentSubTypeList = widget.subtypeList!;
    userFavouriteCategoryListFromDB = widget.favCatgoryList!;
    context.read<LoaddatapartbypartCubit>().getProducts();

    scrollController.addListener(() async {
      if (scrollController.position.extentAfter == 0) {
        print('major cakking get more products');
        context
            .read<LoaddatapartbypartCubit>()
            .getMoreProducts(list, lastDocData!, context, docLength);
      }
    });

    //showFavouritesCategoryDialogAutomatic();
    super.initState();
  }

  var appUserName;
  var msgUpdate;
  var checkMobileNumberLinked;
  var versionNo, versionNumberFromServer, updateType;
  List<dynamic> currentSubTypeList = [];
  List<String>? localSubTypeList = [];

  showFavouritesCategoryDialogAutomatic() async {
    var pref1 = await SharedPreferences.getInstance();
    print('localS entered');
    List<String> locListForPref = [];

    localSubTypeList =
        await LocalArticleCAtegorySharedPreferences().getLocalCategories(pref1);
    print('localS entered ghghhghg');
    Future.delayed(Duration(seconds: 0), () {
      if (localSubTypeList != null) {
        if (localSubTypeList!.length != currentSubTypeList.length) {
          print('local length ${localSubTypeList!.length}');
          for (var i in currentSubTypeList) {
            locListForPref.add(i.subTypeName.toString());
            LocalArticleCAtegorySharedPreferences()
                .setLocalCategories(locListForPref, pref);
          }
          if (FirebaseAuth.instance.currentUser != null) {
            showFavouritesCategoryDialogManual();
          }
        } else {
          for (var i in currentSubTypeList) {
            locListForPref.add(i.subTypeName.toString());
            LocalArticleCAtegorySharedPreferences()
                .setLocalCategories(locListForPref, pref);
          }
        }
      } else {
        for (var i in currentSubTypeList) {
          locListForPref.add(i.subTypeName.toString());
          LocalArticleCAtegorySharedPreferences()
              .setLocalCategories(locListForPref, pref);
        }
        print('localS me');
        if (FirebaseAuth.instance.currentUser != null) {
          showFavouritesCategoryDialogManual();
        }
      }
    });
  }

  triggerShowFavouritesCategoryDialogManual(bool trigger) {
    if (trigger) {
      showFavouritesCategoryDialogManual();
    }
  }

  showFavouritesCategoryDialogManual() async {
    Future.delayed(Duration(milliseconds: 800), () async {
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),

                //backgroundColor: Colors.transparent,
                title: Text('Add Favourites').text.bold.xl3.underline.make(),
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
                        .height(context.screenWidth * 0.825)
                        .make(),
                    15.heightBox,
                    ElevatedButton(
                        onPressed: () async {
                          if (FirebaseAuth.instance.currentUser != null) {
                            List<String> listForPref = [];
                            print(
                                'nnn new Done $userFavouriteCategoryListFromDB');
                            if (userFavouriteCategoryListFromDB.isNotEmpty) {
                              print('nnn r1');
                              for (var o in userFavouriteCategoryListFromDB) {
                                listForPref.add(o.toString());
                                FavArticleSharedPreferences()
                                    .setFavCategories(listForPref, pref);
                              }
                            } else {
                              print('nnn r2');
                              FavArticleSharedPreferences()
                                  .setFavCategories([], pref);
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
                            context
                                .read<FavouritepreferenceCubit>()
                                .getFavCategoryFromPref(pref);
                            Navigator.pop(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserNotLoggedInScreen()));
                          }
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
    Future.delayed(Duration(seconds: 10), () {
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
                              width: context.screenWidth * 0.75,
                              height: context.screenHeight * 0.45,
                            ).box.make().positioned(
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
                              ],
                              alignment: updateType != 'Forced'
                                  ? MainAxisAlignment.spaceEvenly
                                  : MainAxisAlignment.center,
                            )
                                .box
                                .width(context.screenWidth * 0.75)
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

  @override
  Widget build(BuildContext context) {
/*     final articleCubit = BlocProvider.of<ArticleCubit>(context); */
    final selecetedCategory = BlocProvider.of<SelectedcategoryCubit>(context);

    final favCategoryPrefCubit =
        BlocProvider.of<FavouritepreferenceCubit>(context);

    return Scaffold(
      /* bottomNavigationBar: Container(
        width: context.screenWidth,
        height: context.screenWidth * 0.16,
        child: AdWidget(
          ad: bAd..load(),
          key: UniqueKey(),
        ),
      ), */
      appBar: AppBar(
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
          /* FirebaseAuth.instance.currentUser != null
              ? IconButton(
                  onPressed: () {
                    showFavouritesCategoryDialogManual();
                  },
                  icon: Icon(Icons.add_task))
              : Container(), */
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
      drawer: AppDrawer(
        trigger: triggerShowFavouritesCategoryDialogManual,
      ),
      body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 0))
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
                                ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: widget.subtypeList!.length + 2,
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
                                                    onDoubleTap: () {},
                                                    onTap: () {
                                                      favCategoryPrefCubit
                                                          .getFavCategoryFromPref(
                                                              pref);
                                                      selecetedCategory
                                                          .getSelectedCategory(
                                                              'Favourites');
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
                                                                        image: CachedNetworkImageProvider(
                                                                            'https://picsum.photos/300'),
                                                                        fit: BoxFit
                                                                            .fill),
                                                                    borderRadius:
                                                                        BorderRadius.circular(getWidth(context) *
                                                                            0.1)),
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
                                                        onDoubleTap: () {
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
                                                        },
                                                        onTap: () {
                                                          favCategoryPrefCubit
                                                              .getFavCategoryFromPref(
                                                                  pref);
                                                          selecetedCategory
                                                              .getSelectedCategory(
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
                                                                            image: CachedNetworkImageProvider(
                                                                                'https://picsum.photos/200'),
                                                                            fit: BoxFit
                                                                                .fill),
                                                                        borderRadius:
                                                                            BorderRadius.circular(getWidth(context) *
                                                                                0.1)),
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
                                                        onDoubleTap: () {
                                                          print(
                                                              'nnn favourite Category List $userFavouriteCategoryListFromDB');
                                                          if (userFavouriteCategoryListFromDB.contains(
                                                              currentSubTypeList[
                                                                      index - 2]
                                                                  .subTypeName
                                                                  .toString())) {
                                                            userFavouriteCategoryListFromDB
                                                                .remove(
                                                                    'Favourites');
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Remove From Favourites'),
                                                                    content: Text(
                                                                        'Removing ${currentSubTypeList[index - 2].subTypeName} From Favourites Section...'),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                          style: ButtonStyle(
                                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(18.0),
                                                                          )
                                                                                  //      side: BorderSide(color: Colors.red)),
                                                                                  )),
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Text('Decline')),
                                                                      ElevatedButton(
                                                                          style: ButtonStyle(
                                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(18.0),
                                                                          )
                                                                                  //      side: BorderSide(color: Colors.red)),
                                                                                  )),
                                                                          onPressed: () {
                                                                            List<String>
                                                                                loc =
                                                                                [];
                                                                            userFavouriteCategoryListFromDB.remove(currentSubTypeList[index - 2].subTypeName.toString());
                                                                            print('remove data $userFavouriteCategoryListFromDB');
                                                                            if (userFavouriteCategoryListFromDB.isNotEmpty) {
                                                                              for (var q in userFavouriteCategoryListFromDB) {
                                                                                loc.add(q);
                                                                                print('remove data 2 $loc');
                                                                                FavArticleSharedPreferences().setFavCategories(loc, pref);
                                                                              }
                                                                            } else {
                                                                              FavArticleSharedPreferences().setFavCategories([], pref);
                                                                            }
                                                                            FirebaseFirestore.instance.collection('UserProfile').doc(FirebaseAuth.instance.currentUser!.uid).update({
                                                                              'UsersFavouriteArticleCategory': userFavouriteCategoryListFromDB
                                                                            });

                                                                            FirebaseFirestore.instance.collection('ArticleSubtype').where('SubType', isEqualTo: currentSubTypeList[index - 2].subTypeName).get().then((value) {
                                                                              if (value.size != 0) {
                                                                                print('nnn new val cominfg');
                                                                                FirebaseFirestore.instance.collection('ArticleSubtype').doc(value.docs.first.id).get().then((val) async {
                                                                                  List<dynamic> help = await val.data()!['PeopleSubscribed'];
                                                                                  if (help.contains(tokenId)) {
                                                                                    help.remove(tokenId);
                                                                                    FirebaseFirestore.instance.collection('ArticleSubtype').doc(value.docs.first.id).update({
                                                                                      'PeopleSubscribed': help
                                                                                    });
                                                                                  }
                                                                                });
                                                                              }
                                                                            });
                                                                            context.read<FavouritepreferenceCubit>().getFavCategoryFromPref(pref);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Text('Accept'))
                                                                    ],
                                                                  );
                                                                });
                                                            print(
                                                                'nnn fav Categ remove');
                                                          } else {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Add To Favourites'),
                                                                    content: Text(
                                                                        'Adding ${currentSubTypeList[index - 2].subTypeName} From Favourites Section...'),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                          style: ButtonStyle(
                                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(18.0),
                                                                          ))),
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Text('Decline')),
                                                                      ElevatedButton(
                                                                          style: ButtonStyle(
                                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(18.0),
                                                                          ))),
                                                                          onPressed: () {
                                                                            List<String>
                                                                                loc =
                                                                                [];
                                                                            userFavouriteCategoryListFromDB.add(currentSubTypeList[index - 2].subTypeName.toString());
                                                                            for (String q
                                                                                in userFavouriteCategoryListFromDB) {
                                                                              loc.add(q);
                                                                              FavArticleSharedPreferences().setFavCategories(loc, pref);
                                                                            }
                                                                            FirebaseFirestore.instance.collection('UserProfile').doc(FirebaseAuth.instance.currentUser!.uid).update({
                                                                              'UsersFavouriteArticleCategory': userFavouriteCategoryListFromDB
                                                                            });

                                                                            FirebaseFirestore.instance.collection('ArticleSubtype').where('SubType', isEqualTo: currentSubTypeList[index - 2].subTypeName).get().then((value) {
                                                                              if (value.size != 0) {
                                                                                print('nnn new val cominfg');
                                                                                FirebaseFirestore.instance.collection('ArticleSubtype').doc(value.docs.first.id).get().then((val) async {
                                                                                  List<dynamic> help = await val.data()!['PeopleSubscribed'];
                                                                                  if (!help.contains(tokenId)) {
                                                                                    help.add(tokenId);
                                                                                    FirebaseFirestore.instance.collection('ArticleSubtype').doc(value.docs.first.id).update({
                                                                                      'PeopleSubscribed': help
                                                                                    });
                                                                                  }
                                                                                });
                                                                              }
                                                                            });
                                                                            context.read<FavouritepreferenceCubit>().getFavCategoryFromPref(pref);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Text('Accept'))
                                                                    ],
                                                                  );
                                                                });
                                                            print(
                                                                'nnn fav Categ add');
                                                          }
                                                        },
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
                                                                              color: sState.selectedCategory! == widget.subtypeList![index - 2].subTypeName.toString() ? Colors.blue : Colors.black)
                                                                        ],
                                                                        image: DecorationImage(
                                                                            image: CachedNetworkImageProvider(widget.subtypeList![index - 2].photoUrl
                                                                                .toString()),
                                                                            fit: BoxFit
                                                                                .fill),
                                                                        borderRadius:
                                                                            BorderRadius.circular(getWidth(context) *
                                                                                0.1)),
                                                                  );
                                                                },
                                                              ),
                                                              Text(
                                                                  widget
                                                                      .subtypeList![
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
                                    .make(),
                                5.heightBox,
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
                                      dataWithAds =
                                          List.from(lState.splitedData ?? []);
                                      for (int t = 1;
                                          t <= lState.splitedData!.length;
                                          t++) {
                                        if (t % 5 == 0) {
                                          dataWithAds.insert(
                                              t,
                                              BannerAdsHelper.getBannerAd()
                                                ..load());
                                        }
                                      }
                                    }
                                    //Todo

                                    print('nnn Products Comming');
                                    return lState.splitedData != null
                                        ? selectedState.selectedCategory ==
                                                'Favourites'
                                            ? Container(
                                                width: getWidth(context),
                                                height:
                                                    getWidth(context) * 1.52,
                                                child: ListView.builder(
                                                    controller:
                                                        scrollController,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        dataWithAds.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return BlocBuilder<
                                                          FavouritepreferenceCubit,
                                                          FavouritepreferenceState>(
                                                        builder:
                                                            (context, pFState) {
                                                          print(
                                                              'nnn pref ${pFState.locFavCategory}');
                                                          if (dataWithAds[index]
                                                              is DocumentSnapshot) {
                                                            ArticlesModel
                                                                model =
                                                                ArticlesModel.fromJson(
                                                                    dataWithAds[
                                                                        index]);
                                                            return pFState
                                                                    .locFavCategory!
                                                                    .contains(model
                                                                        .articleSubType)
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
                                                                          return Future.delayed(
                                                                              Duration(milliseconds: 1500),
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
                                                                                              BlocProvider(create: (context) => StaticarticlelikeCubit()),
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
                                                                                              //articlesModel: model,
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
                                                                                    fromReviewAndReject: false,
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
                                                          } else {
                                                            final Column
                                                                adContent =
                                                                Column(
                                                                    children: [
                                                                  bannerAds(dataWithAds[
                                                                          index]
                                                                      as BannerAd),
                                                                  /* Card(
                                                                      elevation:
                                                                          30,
                                                                      child:
                                                                          Container(
                                                                        width: context
                                                                            .screenWidth,
                                                                        height: context.screenWidth *
                                                                            0.16,
                                                                        child:
                                                                            AdWidget(
                                                                          ad: dataWithAds[index]
                                                                              as BannerAd,
                                                                          key:
                                                                              UniqueKey(),
                                                                        ),
                                                                      )), */
                                                                  13.heightBox
                                                                ]);
                                                            return adContent;
                                                          }
                                                        },
                                                      );
                                                    }))
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
                                                        width:
                                                            getWidth(context),
                                                        height:
                                                            getWidth(context) *
                                                                1.52,
                                                        child: ListView.builder(
                                                            controller:
                                                                scrollController,
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                dataWithAds
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              if (dataWithAds[
                                                                      index]
                                                                  is DocumentSnapshot) {
                                                                ArticlesModel
                                                                    model =
                                                                    ArticlesModel
                                                                        .fromJson(
                                                                            dataWithAds[index]);
                                                                return model.isArticlePublished ==
                                                                        "Published"
                                                                    ? selectedState.selectedCategory ==
                                                                            'All'
                                                                        ? InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => MultiBlocProvider(
                                                                                            providers: [
                                                                                              BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
                                                                                              BlocProvider(create: (context) => StaticarticlelikeCubit()),
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
                                                                                              //articlesModel: model,
                                                                                              checkMobileNumberLinked: checkMobileNumberLinked,
                                                                                              title: model.articletitle!,
                                                                                              fromReviewOrReject: false,
                                                                                              documentId: model.documentId!,
                                                                                              fromNotification: false,
                                                                                              fromEdit: false,
                                                                                            ),
                                                                                          )));
                                                                            },
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                BlocProvider(
                                                                                  create: (context) => CheckuserloginedCubit(),
                                                                                  child: ArticleCard(
                                                                                    fromReviewAndReject: false,
                                                                                    model: model,
                                                                                    docid: model.documentId!,
                                                                                    title: model.articletitle!,
                                                                                    desc: model.articledesc!,
                                                                                  ).box.margin(EdgeInsets.symmetric(horizontal: context.screenWidth * 0.025)).make(),
                                                                                ),
                                                                                13.heightBox
                                                                              ],
                                                                            ))
                                                                        : Container()
                                                                    : Container();
                                                              } else {
                                                                final Column
                                                                    adContent =
                                                                    Column(
                                                                        children: [
                                                                      Card(
                                                                          elevation:
                                                                              30,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                context.screenWidth,
                                                                            height:
                                                                                context.screenWidth * 0.16,
                                                                            child:
                                                                                AdWidget(
                                                                              ad: dataWithAds[index] as BannerAd,
                                                                              key: UniqueKey(),
                                                                            ),
                                                                          )),
                                                                      13.heightBox
                                                                    ]);
                                                                return adContent;
                                                              }
                                                            })),
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
                                                        child: ListView.builder(
                                                            controller:
                                                                scrollController,
                                                            shrinkWrap: true,
                                                            itemCount: lState
                                                                .splitedData!
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              if (dataWithAds[
                                                                      index]
                                                                  is DocumentSnapshot) {
                                                                ArticlesModel
                                                                    model =
                                                                    ArticlesModel
                                                                        .fromJson(
                                                                            dataWithAds[index]);
                                                                return model.isArticlePublished ==
                                                                        "Published"
                                                                    ? selectedState.selectedCategory ==
                                                                            model
                                                                                .articleSubType
                                                                        ? InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => MultiBlocProvider(
                                                                                            providers: [
                                                                                              BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
                                                                                              BlocProvider(create: (context) => StaticarticlelikeCubit()),
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
                                                                                            child: ArticlesDetailViewScreenNew(
                                                                                              articlesModel: model,
                                                                                              title: model.articletitle!,
                                                                                              fromReviewOrReject: false,
                                                                                              documentId: model.documentId!, //snapshot.data.docs[index].id,
                                                                                              fromNotification: false,
                                                                                              fromEdit: false,
                                                                                            ),
                                                                                          )));
                                                                            },
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                BlocProvider(
                                                                                  create: (context) => CheckuserloginedCubit(),
                                                                                  child: ArticleCard(
                                                                                    fromReviewAndReject: false,
                                                                                    model: model,
                                                                                    docid: model.documentId!, //snapshot.data.docs[index].id,
                                                                                    title: model.articletitle!,
                                                                                    desc: model.articledesc!,
                                                                                  ).box.margin(EdgeInsets.symmetric(horizontal: context.screenWidth * 0.025)).make(),
                                                                                ),
                                                                                13.heightBox
                                                                              ],
                                                                            ))
                                                                        : Container()
                                                                    : Container();
                                                              } else {
                                                                final Column
                                                                    adContent =
                                                                    Column(
                                                                        children: [
                                                                      Card(
                                                                          elevation:
                                                                              30,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                context.screenWidth,
                                                                            height:
                                                                                context.screenWidth * 0.16,
                                                                            child:
                                                                                AdWidget(
                                                                              ad: dataWithAds[index] as BannerAd,
                                                                              key: UniqueKey(),
                                                                            ),
                                                                          )),
                                                                      13.heightBox
                                                                    ]);
                                                                return adContent;
                                                              }
                                                            })),
                                                  )
                                        : Center(
                                            child: CircularProgressIndicator(),
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
    );
  }
}

Widget bannerAds(BannerAd bAd) {
  return StatefulBuilder(builder: (context, setStete) {
    print('object building');
    return Container(
      width: context.screenWidth,
      height: context.screenWidth * 0.16,
      child: AdWidget(
        ad: bAd..load(),
      ),
    );
  });
}
