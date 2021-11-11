import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:journz_web/Authentication/AuthenticationBloc/LoginCubit/login_cubit.dart';
import 'package:journz_web/Authentication/AuthenticationBloc/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import 'package:journz_web/Authentication/Screens/InitialAccountSelection.dart';

import 'package:journz_web/Common/AppTheme/ThemeBloc/theme_bloc.dart';
import 'package:journz_web/Common/Helper/AuthorRequestCubit/authorrequest_cubit.dart';
import 'package:journz_web/Common/Helper/BottomNavBar/bottomnavbar_cubit.dart';
import 'package:journz_web/Common/Helper/BottomScrollCubit/bottomscroll_cubit.dart';
import 'package:journz_web/Common/Helper/ConnectivityCubit/connectivity_cubit.dart';
import 'package:journz_web/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
import 'package:journz_web/Common/Helper/SharedPrefCubitForSettingsScreen/sharedpref_cubit.dart';

import 'package:journz_web/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import 'package:journz_web/ContactUs/Screen/contact_us.dart';
import 'package:journz_web/Marketing/Screen/MarketingScreen.dart';
import 'package:journz_web/Marketing/Screen/marketing_screen_youtube.dart';

import 'package:journz_web/articleDetailsView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
import 'package:journz_web/articleDetailsView/ArticlesDetailViewCubit/DetailViewCubit/articlesdetail_cubit.dart';
import 'package:journz_web/articleDetailsView/detailspage.dart';
import 'package:journz_web/constants/splashscreen.dart';
import 'package:journz_web/homePage/Bloc/DrawerNameCubit/drawername_cubit.dart';
import 'package:journz_web/homePage/Bloc/FavouritePreferencesCubit/favouritepreference_cubit.dart';
//import 'package:journz_web/Pages/homepage.dart';
import 'package:journz_web/homePage/newhomepage.dart';
import 'package:journz_web/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';

import 'PrivacyPolicy/Screen/privacypolicy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  Vx.isWeb;
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const CircularProgressIndicator();
      },
    );
  }
}

class MyObs extends VxObserver {
  @override
  void didChangeRoute(Uri route, Page page, String pushOrPop) {
    print("${route.path} - $pushOrPop");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    print('Pushed a route');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('Popped a route');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var pref1;

  @override
  void initState() {
    getSharedPref();

    super.initState();
  }

  getSharedPref() async {
    FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        //   providers: [
        //     BlocProvider(create: (context) => FavouritepreferenceCubit()),
        //     BlocProvider(create: (context) => ThemeBloc()),
        //     BlocProvider(create: (context) => ArticlesdetailCubit()),
        //     BlocProvider(create: (context) => ArticlelikeCubit()),
        //     //BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
        //     //BlocProvider(create: (context) => ArticleswapCubit()),
        //     BlocProvider(create: (context) => SharedprefCubit(pref1)),
        //     BlocProvider(create: (context) => BottomscrollCubit()),
        //     BlocProvider(create: (context) => AuthorrequestCubit()),
        //     BlocProvider(create: (context) => BottomnavbarCubit()),
        //     BlocProvider(create: (context) => ShowhidepasswordCubit()),
        //     BlocProvider(create: (context) => LoginCubit()),
        //     BlocProvider(create: (context) => DrawernameCubit()),
        //     BlocProvider(create: (context) => LoadingscreenCubit()),
        //     BlocProvider(create: (context) => ConnectivityCubit()),
        //     BlocProvider(create: (context) => ThemebasedwidgetCubit()),
        //   ],
        //   child: MaterialApp.router(
        //     title: 'Journz',
        //     debugShowCheckedModeBanner: false,
        //     theme: ThemeData(
        //       canvasColor: Colors.grey[100],
        //       //fontFamily: GoogleFonts.poppins().fontFamily,
        //       //primarySwatch: Colors.blue,
        //     ),
        //     routeInformationParser: VxInformationParser(),
        //     routerDelegate: VxNavigator(observers: [
        //       MyObs()
        //     ], routes: {
        //       // MyRoutes.initialAccountSelection: (_, __) =>
        //       //     const MaterialPage(child: ThemeLoader()),
        //       MyRoutes.loading: (_, __) => MaterialPage(child: SplashScreen()),
        //       "/home": (_, __) => const MaterialPage(child: HomePage()),
        //       MyRoutes.homeRoute: (_, __) => const MaterialPage(child: HomePage()),
        //       MyRoutes.detailnewRoute: (uri, __) {
        //         //print(uri.queryParameters['id']);
        //         var id = uri.queryParameters['id'];
        //         //var type = uri.queryParameters['type'];
        //         return MaterialPage(
        //             child: DetailsPage(
        //           id: id!,
        //         ));
        //       }
        //     }),
        //     //home: const HomePage(),
        //   ),
        // );
        providers: [
          BlocProvider(create: (context) => FavouritepreferenceCubit()),
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => ArticlesdetailCubit()),
          BlocProvider(create: (context) => ArticlelikeCubit()),
          //BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
          //BlocProvider(create: (context) => ArticleswapCubit()),
          BlocProvider(create: (context) => SharedprefCubit(pref1)),
          BlocProvider(create: (context) => BottomscrollCubit()),
          BlocProvider(create: (context) => AuthorrequestCubit()),
          BlocProvider(create: (context) => BottomnavbarCubit()),
          BlocProvider(create: (context) => ShowhidepasswordCubit()),
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => DrawernameCubit()),
          BlocProvider(create: (context) => LoadingscreenCubit()),
          BlocProvider(create: (context) => ConnectivityCubit()),
          BlocProvider(create: (context) => ThemebasedwidgetCubit()),
        ],
        child: MaterialApp.router(
          title: 'Journz',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: Colors.grey[100],
            //fontFamily: GoogleFonts.poppins().fontFamily,
            //primarySwatch: Colors.blue,
          ),
          routeInformationParser: VxInformationParser(),
          routerDelegate: VxNavigator(routes: {
            MyRoutes.loading: (_, __) => MaterialPage(child: SplashScreen()),
            "/home": (_, __) => const MaterialPage(child: HomePage()),
            MyRoutes.homeRoute: (_, __) =>
                const MaterialPage(child: HomePage()),
            MyRoutes.detailnewRoute: (uri, __) {
              var id = uri.queryParameters['id'];
              var type = uri.queryParameters['type'];
              if (type == "/Articles") {
                return MaterialPage(child: DetailsPage(id: id!));
              } else if (type == "/PrivacyPolicy") {
                return const MaterialPage(child: PrivacyPolicy());
              } else if (type == "/ContactUs") {
                return const MaterialPage(child: ContactUs());
              } else if (type == "/Marketing") {
                return MaterialPage(child: MarketingScreen());
              } else {
                return const MaterialPage(child: HomePage());
              }
            },
          }),
        ));
  }
}

class ThemeLoader extends StatefulWidget {
  const ThemeLoader({Key? key}) : super(key: key);

  @override
  _ThemeLoaderState createState() => _ThemeLoaderState();
}

class _ThemeLoaderState extends State<ThemeLoader> {
  var pre;
  var versionNo;
  var versionNumberFromServer;
  bool? startupThemeShown;
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  doThisOnLaunch() async {
    await getSharedPref();
    //await listenForNotification();
    //await initialCheck();
  }

  getSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pre = pref;
    // _loadTheme(pref);
    // startupThemeShown = await StartupThemePreferences().getShown(pref);
    if (FirebaseAuth.instance.currentUser != null) {
      if (!FirebaseAuth.instance.currentUser!.isAnonymous) {
        _messaging.getToken().then((value) async {
          print('nnn not token $value');
          FirebaseFirestore.instance
              .collection('UserProfile')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((val) {
            if (val.data()!.containsKey('NotificationToken')) {
              FirebaseFirestore.instance
                  .collection('UserProfile')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({'NotificationToken': value});
            } else {
              FirebaseFirestore.instance
                  .collection('UserProfile')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({'NotificationToken': value});
            }
          });
          print('message token $value');
          FirebaseFirestore.instance
              .collection('GeneralAppUserNotificationToken')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({'NotificationToken': value});
        });
      }
    }
  }

  // _loadTheme(SharedPreferences preferences) {
  //   //print('pref theme ${Preferences.getTheme(preferences,context.read<ThemeBasedWidgetCubit>())}');
  //   context.read<ThemeBloc>().add(ThemeEvent(
  //       appTheme: Preferences.getTheme(
  //           preferences, context.read<ThemebasedwidgetCubit>())));
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 500))
            .then((value) => Future.value(true)),
        builder: (context, snapshot) {
          print('nnn shown or not $startupThemeShown');
          return snapshot.hasData
              ? FirebaseAuth.instance.currentUser == null
                  ? InitialAccountSelection()
                  : BlocProvider(
                      create: (context) => SharedprefCubit(pre),
                      child: HomePage(),
                    )
              : Center(
                  child: CircularProgressIndicator(
                  color: Colors.amber,
                ));
        });
  }
}
