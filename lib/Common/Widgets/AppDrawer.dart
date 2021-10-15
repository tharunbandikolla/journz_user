import 'package:Journz/Common/AppTheme/ThemeBloc/theme_bloc.dart';
import 'package:Journz/Common/Constant/Constants.dart';
import 'package:Journz/Common/Helper/StartupThemeHelperCubit/startupthemehelper_cubit.dart';
import 'package:Journz/Common/Screens/BannerAdsScreen.dart';
import 'package:Journz/HomeScreen/Bloc/DrawerNameCubit/drawername_cubit.dart';

import 'package:Journz/UserProfile/Screen/UserNotLoggedInScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/Articles/ArticlesBloc/GalleryPhotoCubit/galleryphoto_cubit.dart';
import '/Articles/ArticlesBloc/UploadGalleryImage/uploadgalleryimg_cubit.dart';
import '/ArticlesReview/Screens/ArticlesPublishedScreen.dart';
import '/Authentication/AuthenticationBloc/SignupCheckboxCubit/signupcheckbox_cubit.dart';
import '/Common/Helper/AuthorRequestCubit/authorrequest_cubit.dart';

import '/UserProfile/Screen/NewUserProfileScreen.dart';

import '/ArticleDetailView/ArticlesDetailViewCubit/BookmarkScreenCubit/bookmarkscreen_cubit.dart';
import '/ArticleDetailView/Screen/BookmarkedArticlesScreen.dart';
import '/Articles/ArticlesBloc/AddPhotoToArticle/addphototoarticle_cubit.dart';
import '/Articles/ArticlesBloc/ArticlesSubtypeCubit/articlesubtype_cubit.dart';
import '/Articles/ArticlesBloc/SearchTagCubit/SearchTag_cubit.dart';
import '/Articles/Screens/ArticlesCreation.dart';
import '/ArticlesReview/Cubit/cubit/Reviewarticlestream_cubit.dart';
import '/ArticlesReview/Screens/ArticleUnderReviewScreen.dart';
import '/ArticlesReview/Screens/ArticlesRejectedScreen.dart';
import '/Authentication/AuthenticationBloc/LoginCubit/login_cubit.dart';
import '/Authentication/AuthenticationBloc/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import '/Authentication/Screens/LoginScreen.dart';
import '/Authentication/Screens/VerifyEmail.dart';

import 'package:Journz/Articles/ArticlesBloc/AddPhotoToArticle/addphototoarticle_cubit.dart';
import 'package:Journz/Articles/ArticlesBloc/ArticlesSubtypeCubit/articlesubtype_cubit.dart';
import 'package:Journz/ArticlesReview/Cubit/cubit/Reviewarticlestream_cubit.dart';
import 'package:Journz/ArticlesReview/Screens/ArticlesRejectedScreen.dart';
import 'package:Journz/Authentication/AuthenticationBloc/LoginCubit/login_cubit.dart';
import 'package:Journz/Authentication/AuthenticationBloc/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import 'package:Journz/Authentication/Screens/LoginScreen.dart';
import 'package:Journz/Authentication/Screens/VerifyEmail.dart';
import 'package:Journz/Common/AppTheme/AppTheme.dart';
import 'package:Journz/Common/AppTheme/ThemePreferenses.dart';
import 'package:Journz/Common/Helper/AuthorRequestCubit/authorrequest_cubit.dart';

import 'package:Journz/Common/Helper/SharedPrefCubitForSettingsScreen/sharedpref_cubit.dart';
import 'package:Journz/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';

import 'package:Journz/Common/Screens/SettingsScreen.dart';
import 'package:Journz/HomeScreen/Screen/HomeScreen.dart';
import 'package:Journz/UserProfile/Screen/NewUserProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class AppDrawer extends StatefulWidget {
  Function(bool) trigger;
  AppDrawer({Key? key, required this.trigger}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var pref1;

  String? versionNo;
  getSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref1 = pref;
    _loadTheme(pref);
  }

  _loadTheme(SharedPreferences preferences) {
    //print('pref theme ${Preferences.getTheme(preferences)}');
    context.read<ThemeBloc>().add(ThemeEvent(
        appTheme: Preferences.getTheme(
            preferences, context.read<ThemebasedwidgetCubit>())));
  }

  getVersionNo() async {
    PackageInfo p = await PackageInfo.fromPlatform();
    versionNo = p.version;
  }

  @override
  void initState() {
    getSharedPref();
    getVersionNo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final preference = BlocProvider.of<SharedprefCubit>(context);
    preference.getSharedPref();
    final theme = BlocProvider.of<ThemeBloc>(context);

    _setTheme(bool darkTheme, SharedPreferences preferences) {
      AppTheme selectedTheme =
          darkTheme ? AppTheme.lightTheme : AppTheme.darkTheme;

      theme.add(ThemeEvent(appTheme: selectedTheme));
      Preferences.saveTheme(selectedTheme, preferences);
      //   print('pref theme ${Preferences.getTheme(preferences)}');
    }

    return SafeArea(
        child: Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FirebaseAuth.instance.currentUser != null
              ? Card(
                  elevation: 10,
                  child: BlocBuilder<DrawernameCubit, DrawernameState>(
                    builder: (context, state) {
                      print(
                          'nnn draewr ${state.drawerName}, ${state.drawerEmail} ${state.photoUrl}');
                      return InkWell(
                        onTap: () {
                          FirebaseAuth.instance.currentUser != null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewUserProfileScreen()))
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserNotLoggedInScreen()));
                        },
                        child: Container(
                          width: getWidth(context),
                          height: getWidth(context) * 0.5,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              state.photoUrl == 'images/fluenzologo.png'
                                  ? CircleAvatar(
                                      backgroundImage:
                                          AssetImage('images/fluenzologo.png'),
                                      maxRadius: getWidth(context) * 0.14)
                                  : CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              state.photoUrl),
                                      maxRadius: getWidth(context) * 0.14),
                              SizedBox(height: getWidth(context) * 0.02),
                              Text(state.drawerName,
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(height: getWidth(context) * 0.01),
                              Text(state.drawerEmail,
                                  style: Theme.of(context).textTheme.headline6),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  width: getWidth(context),
                  height: getWidth(context) * 0.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/mobileUser.png'),
                          fit: BoxFit.fill)),
                ),
          Container(
            padding: EdgeInsets.all(getWidth(context) * 0.03),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FirebaseAuth.instance.currentUser != null
                      ? ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            ExpansionTile(
                              //backgroundColor: Colors.grey[300],
                              expandedAlignment: Alignment.centerLeft,
                              title: Text(
                                "Articles",
                              ).text.xl2.bold.make(),
                              children: <Widget>[
                                FirebaseAuth.instance.currentUser != null
                                    ? BlocBuilder<DrawernameCubit,
                                        DrawernameState>(
                                        builder: (context, state) {
                                          print('nnnn role ${state.role}');
                                          return state.role == "Author" ||
                                                  state.role == 'ContentWriter'
                                              ? TextButton(
                                                  onPressed: () {
                                                    print(
                                                        'nnn uid ${FirebaseAuth.instance.currentUser!.uid}');
                                                    Navigator.pop(context);

                                                    FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .emailVerified
                                                        ? Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MultiBlocProvider(
                                                                          providers: [
                                                                            BlocProvider(create: (context) => SearchTagCubit()),
                                                                            BlocProvider(create: (context) => ArticlesubtypeCubit()),
                                                                            BlocProvider(create: (context) => SignupcheckboxCubit()),
                                                                            BlocProvider(create: (context) => GalleryphotoCubit()),
                                                                            BlocProvider(create: (context) => AddphotoarticleCubit()),
                                                                            BlocProvider(create: (context) => UploadgalleryimgCubit()),
                                                                          ],
                                                                          child:
                                                                              ArticlesCreation(
                                                                            fromEdit:
                                                                                false,
                                                                          ),
                                                                        )))
                                                        : Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        VerifyEmailScreen()));
                                                  },
                                                  child: Text(
                                                    'Add Articles',
                                                  ).text.xl.make(),
                                                )
                                                  .box
                                                  .px16
                                                  .alignCenterLeft
                                                  .width(context.screenWidth)
                                                  .height(context.screenWidth *
                                                      0.12)
                                                  .make()
                                              : Container();
                                        },
                                      )
                                    : Container(),
                                FirebaseAuth.instance.currentUser != null
                                    ? TextButton(
                                        onPressed: () {
                                          print(
                                              'nnn uid ${FirebaseAuth.instance.currentUser!.uid}');
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider(
                                                                create: (context) =>
                                                                    BookmarkscreenCubit()),
                                                          ],
                                                          child:
                                                              BookmarkedArticlesScreen())));
                                        },
                                        child: Text(
                                          'Favourite Articles',
                                        ).text.xl.make(),
                                      )
                                        .box
                                        .px16
                                        .alignCenterLeft
                                        .width(context.screenWidth)
                                        .height(context.screenWidth * 0.12)
                                        .make()
                                    : Container(),
                                /*                ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => TestsliverCubit(),
                                      child: SliverHomeScreen(),
                                    )));
                      },
                      child: Text('Sliver')),*/

                                FirebaseAuth.instance.currentUser != null
                                    ? BlocBuilder<DrawernameCubit,
                                        DrawernameState>(
                                        builder: (context, state) {
                                          print('nnnn role ${state.role}');
                                          return state.role == "Author" ||
                                                  state.role == 'ContentWriter'
                                              ? TextButton(
                                                  onPressed: () {
                                                    print(
                                                        'nnn uid ${FirebaseAuth.instance.currentUser!.uid}');
                                                    Navigator.pop(context);

                                                    FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .emailVerified
                                                        ? Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MultiBlocProvider(
                                                                        providers: [
                                                                          BlocProvider(
                                                                              create: (context) => ReviewarticlestreamCubit()),
                                                                          BlocProvider(
                                                                              create: (context) => ArticlesubtypeCubit()),
                                                                          BlocProvider(
                                                                              create: (context) => AddphotoarticleCubit()),
                                                                        ],
                                                                        child:
                                                                            ArticlesPublishedScreen())))
                                                        : Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        VerifyEmailScreen()));
                                                  },
                                                  child: Text(
                                                    'Articles Published',
                                                  ).text.xl.make(),
                                                )
                                                  .box
                                                  .px16
                                                  .alignCenterLeft
                                                  .width(context.screenWidth)
                                                  .height(context.screenWidth *
                                                      0.12)
                                                  .make()
                                              : Container();
                                        },
                                      )
                                    : Container(),
                                /*FirebaseAuth.instance.currentUser != null
                      ? BlocBuilder<DrawernameCubit, DrawernameState>(
                          builder: (context, state) {
                            print('nnnn role ${state.role}');
                            return state.role == "Author"
                                ? TextButton(
                                    onPressed: () {
                                      print(
                                          'nnn uid ${FirebaseAuth.instance.currentUser!.uid}');
                                      Navigator.pop(context);

                                      FirebaseAuth.instance.currentUser!
                                              .emailVerified
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider(
                                                                create: (context) =>
                                                                    ReviewarticlestreamCubit()),
                                                            BlocProvider(
                                                                create: (context) =>
                                                                    ArticlesubtypeCubit()),
                                                            BlocProvider(
                                                                create: (context) =>
                                                                    AddphotoarticleCubit()),
                                                          ],
                                                          child:
                                                              ArticlesNotPubishedScreen())))
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VerifyEmailScreen()));
                                    },
                                    child: Text(
                                      'Articles Not Published',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6,
                                    ),
                                  )
                                : Container();
                          },
                        )
                      : Container(),*/
                                FirebaseAuth.instance.currentUser != null
                                    ? BlocBuilder<DrawernameCubit,
                                        DrawernameState>(
                                        builder: (context, state) {
                                          print('nnnn role ${state.role}');
                                          return state.role == "Author" ||
                                                  state.role == 'ContentWriter'
                                              ? TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .emailVerified
                                                        ? Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MultiBlocProvider(
                                                                          providers: [
                                                                            BlocProvider(create: (context) => ReviewarticlestreamCubit()),
                                                                            BlocProvider(create: (context) => ArticlesubtypeCubit()),
                                                                            BlocProvider(create: (context) => AddphotoarticleCubit()),
                                                                          ],
                                                                          child:
                                                                              ArticleUnderReviewScreen(),
                                                                        )))
                                                        : Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        VerifyEmailScreen()));
                                                  },
                                                  child: Text(
                                                    'Articles Under Review',
                                                  ).text.xl.make(),
                                                )
                                                  .box
                                                  .px16
                                                  .alignCenterLeft
                                                  .width(context.screenWidth)
                                                  .height(context.screenWidth *
                                                      0.12)
                                                  .make()
                                              : Container();
                                        },
                                      )
                                    : Container(),
                                FirebaseAuth.instance.currentUser != null
                                    ? BlocBuilder<DrawernameCubit,
                                        DrawernameState>(
                                        builder: (context, state) {
                                          print('nnnn role ${state.role}');
                                          return state.role == "Author" ||
                                                  state.role == 'ContentWriter'
                                              ? TextButton(
                                                  onPressed: () {
                                                    print(
                                                        'nnn uid ${FirebaseAuth.instance.currentUser!.uid}');
                                                    Navigator.pop(context);

                                                    FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .emailVerified
                                                        ? Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MultiBlocProvider(
                                                                          providers: [
                                                                            BlocProvider(create: (context) => ReviewarticlestreamCubit()),
                                                                            BlocProvider(create: (context) => ArticlesubtypeCubit()),
                                                                            BlocProvider(create: (context) => AddphotoarticleCubit()),
                                                                          ],
                                                                          child:
                                                                              ArticlesRejectedScreen(),
                                                                        )))
                                                        : Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        VerifyEmailScreen()));
                                                  },
                                                  child: Text(
                                                    'Articles Rejected',
                                                  ).text.xl.make(),
                                                )
                                                  .box
                                                  .px16
                                                  .alignCenterLeft
                                                  .width(context.screenWidth)
                                                  .height(context.screenWidth *
                                                      0.12)
                                                  .make()
                                              : Container();
                                        },
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                  FirebaseAuth.instance.currentUser != null
                      ? TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            widget.trigger(true);
                          },
                          child: Text('Add Favourites').text.xl2.bold.make(),
                        )
                          .box
                          .px8
                          .alignCenterLeft
                          .width(context.screenWidth)
                          .height(context.screenWidth * 0.12)
                          .make()
                      : Container(),
                  FirebaseAuth.instance.currentUser == null
                      ? TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MultiBlocProvider(providers: [
                                          BlocProvider(
                                              create: (context) =>
                                                  ShowhidepasswordCubit()),
                                          BlocProvider(
                                              create: (context) => LoginCubit())
                                        ], child: LoginScreen())));
                          },
                          child: Text('Login').text.xl2.bold.make(),
                        )
                          .box
                          .px8
                          .alignCenterLeft
                          .width(context.screenWidth)
                          .height(context.screenWidth * 0.12)
                          .make()
                      : Container(),
                  FirebaseAuth.instance.currentUser != null
                      ? TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewUserProfileScreen()));
                          },
                          child: Text(
                            'Profile',
                          ).text.xl2.bold.make(),
                        )
                          .box
                          .px8
                          .alignCenterLeft
                          .width(context.screenWidth)
                          .height(context.screenWidth * 0.12)
                          .make()
                      : Container(),
                  FirebaseAuth.instance.currentUser != null
                      ? TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) =>
                                              AuthorrequestCubit(),
                                          child: SettingsScreen(),
                                        )));
                          },
                          style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.red;
                            return null;
                          })),
                          child: Text(
                            'Settings',
                          ).text.xl2.bold.make(),
                        )
                          .box
                          .px8
                          .alignCenterLeft
                          .width(context.screenWidth)
                          .height(context.screenWidth * 0.12)
                          .make()
                      : Container(),
                  BlocBuilder<SharedprefCubit, SharedprefState>(
                    builder: (context, state) {
                      return Container(
                        ///     padding: EdgeInsets.all(getWidth(context) * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Change Theme',
                            ) //.text.xl2.bold.make()
                                .text
                                .xl2
                                .bold
                                .make()
                                .box
                                .px16
                                .alignCenterLeft
                                .width(context.screenWidth * 0.5)
                                .height(context.screenWidth * 0.12)
                                .make(),
                            Switch(
                              value: Preferences.getTheme(state.pref,
                                      context.read<ThemebasedwidgetCubit>()) ==
                                  AppTheme.lightTheme,
                              onChanged: (val) {
                                print('nnn Theme val ');
                                // print(
                                //   'nnn ${Preferences.getTheme(state.pref) == AppTheme.lightTheme}');
                                _setTheme(val, state.pref);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  FirebaseAuth.instance.currentUser != null
                      ? TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if (FirebaseAuth.instance.currentUser != null) {
                              FirebaseAuth.instance.signOut().then(
                                    (value) => Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                            curIndex: 0,
                                          ),
                                        ),
                                        (route) => false),
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('You Signed Out Successfully')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('You Are Not Logged In')));
                            }
                          },
                          child: Text(
                            'Sign out',
                          ).text.xl2.bold.make(),
                        )
                          .box
                          .px8
                          .alignCenterLeft
                          .width(context.screenWidth)
                          .height(context.screenWidth * 0.12)
                          .make()
                      : Container(),
                ]),
          ),
          Spacer(),
          FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? "Version - $versionNo"
                        .text
                        .xl
                        .make()
                        .box
                        .p12
                        .alignCenter
                        .make()
                    : Container();
              })
        ],
      ),
    ));
  }
}
