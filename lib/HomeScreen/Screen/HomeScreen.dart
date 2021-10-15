/*
A4624264 regex =(?:-[A-Z][0-9].*)
ALPHANUMERIC REGEX = (?:-[A-Za-z0-9].*)
DOCUMENT iD REGEX = (?:\/NotificationDiverter-)

*/

import 'package:Journz/Common/Screens/NewPlannedHomeScreen.dart';
import 'package:Journz/HomeScreen/Bloc/HomeScreenLike/homescreenlike_cubit.dart';
import 'package:Journz/HomeScreen/Bloc/PlannedHomeScreenBloc/plannedhomescreen_bloc.dart';
import 'package:Journz/HomeScreen/Bloc/SelectedCategoryCubit/selectedcategory_cubit.dart';
import 'package:Journz/HomeScreen/Screen/HomeScreenArticleSection.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '/Common/Helper/LoadDataPartByPartCubit/loaddatapartbypart_cubit.dart';

import '/HomeScreen/Bloc/FavouriteCategoryCubit/favouritecategory_cubit.dart';
import '/Common/AppTheme/AppTheme.dart';
import '/Common/Helper/SharedPrefCubitForSettingsScreen/sharedpref_cubit.dart';
import '/Common/AppTheme/ThemeBloc/theme_bloc.dart';
import '/Common/AppTheme/ThemePreferenses.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Helper/BottomNavBar/bottomnavbar_cubit.dart';
import '/Common/Helper/ConnectivityCubit/connectivity_cubit.dart';
import '/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';

import '/HomeScreen/Bloc/ArticleCubit/article_cubit.dart';
import '/HomeScreen/Bloc/DrawerNameCubit/drawername_cubit.dart';

import '/HomeScreen/Screen/Tab2HomeScreen.dart';

import '/UserProfile/Screen/UserNotLoggedInScreen.dart';
import '/UserProfile/Screen/UserProfileScreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final int curIndex;
  const HomeScreen({Key? key, required this.curIndex}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
//    getSharedPref();

    context.read<LoadingscreenCubit>().changeLoadingState(true);
//    versionControl();
    int _currentIndex = widget.curIndex;
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.reload();
      context.read<DrawernameCubit>().getDrawerNameAndEmail();
    }

    super.initState();
  }

//  int _currentIndex = 0;
  List<Widget> _tabs = <Widget>[
    /* 
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => ArticleCubit()),
      BlocProvider(create: (context) => FavouritecategoryCubit()),
      BlocProvider(create: (context) => HomescreenlikeCubit()),
      BlocProvider(create: (context) => LoaddatapartbypartCubit()),
      BlocProvider(create: (context) => SelectedcategoryCubit()),
    ], child: HomeScreenArticleSection()), */
    BlocProvider(
      create: (context) => PlannedhomescreenBloc(PlannedhomescreenInitial()),
      child: NewPlannedHomeScreen(),
    ),
/*     MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabbarindexchangerCubit(),
        ),
        BlocProvider(
          create: (context) => FavouritecategoryCubit(),
        ),
        BlocProvider(
          create: (context) => FavouritepreferenceCubit(),
        ),
        BlocProvider(
          create: (context) => LoaddatapartbypartCubit(),
        ),
      ],
      child: SliverHomeScreen(),
    ),
 */
    Tab2HomeScreen(message: 'News'),
    Tab2HomeScreen(message: 'FunBits'),
    Tab2HomeScreen(message: 'Chat'),
    FirebaseAuth.instance.currentUser != null
        ? UserProfileScreen()
        : UserNotLoggedInScreen()
  ];

  late User? user;

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  /*void _onTapItem(value) {
    setState(() {
      _currentIndex = value;
    });
  }*/

  //var postId;
  @override
  Widget build(BuildContext context) {
    //final drawerCubit = BlocProvider.of<DrawernameCubit>(context);
    // drawerCubit.getDrawerNameAndEmail();
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

    return Scaffold(
      /* bottomSheet: FutureBuilder(
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
                            : DraggableScrollableSheet(
                                initialChildSize: 0.4,
                                minChildSize: 0.2,
                                maxChildSize: 0.6,
                                builder: (context, scrollController) {
                                  return Container(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('close')),
                                    color: Colors.blue,
                                    height: 300,
                                    width: 200,
                                  );
                                })
                        : Container();
                  },
                )
              : Container();
        },
      ),*/

      body: BlocBuilder<ConnectivityCubit, ConnectivityState>(
        builder: (context, state) {
          print('nnn home connect ${state.connectivity!}');
          return state.connectivity!
              ? BlocBuilder<BottomnavbarCubit, BottomnavbarState>(
                  builder: (context, state) {
                    print('nnn state Crr index ${state.currentIndex}');
                    return Container(
                      height: MediaQuery.of(context).size.height * 1.2,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: getWidth(context),
                              height: MediaQuery.of(context).size.height,
                              child: _tabs.elementAt(state.currentIndex),
                            ),
                          ),
                          /*Positioned(
                            bottom: 2.5,
                            //right: 0,
                            child: Container(
                                width: getWidth(context),
                                height: getWidth(context) * 0.18,
                                child: BottomNavBarWidget()),
                          )*/
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No Internet'),
                );
        },
      ),
    );
  }
}
