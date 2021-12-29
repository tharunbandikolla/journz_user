import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journz_web/Articles/Comments/hive_articles_comments.dart';
import 'package:journz_web/Articles/Cubit/ShowArticleData/show_article_data_cubit.dart';
import 'package:journz_web/Articles/Page/detailed_article_screen.dart';
import 'package:journz_web/Common/Cubits/CheckInternetConnection/check_internet_connection_cubit.dart';

import 'package:journz_web/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import 'package:journz_web/HiveArticlesModel/GetArticlesFromCloud/get_articles_from_cloud_cubit.dart';

import 'package:journz_web/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import 'package:journz_web/NewHomePage/Cubits/ShowHideLoginPasswordCubit/show_hide_login_password_cubit.dart';
import 'package:journz_web/NewHomePage/Cubits/get_articles_subtype_cubit/get_article_subtype_cubit.dart';

import 'package:journz_web/utils/routes.dart';

import 'package:velocity_x/velocity_x.dart';

import 'NewHomePage/ContactUs/Screen/contact_us.dart';
import 'NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'NewHomePage/LocalDatabase/HiveArticleSubtypeModel/hive_article_subtype_model.dart';
import 'NewHomePage/Marketing/Screen/MarketingScreen.dart';
import 'NewHomePage/Page/new_home_page.dart';
import 'NewHomePage/PrivacyPolicy/Screen/privacypolicy.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _enablePlatformOverrideForDesktop();
  await Hive.initFlutter();

  Hive.registerAdapter(HiveArticlesSubtypesAdapter());
  await Hive.openBox<HiveArticlesSubtypes>('HiveArticlesSubtype01');

  Hive.registerAdapter(HiveArticleDataAdapter());
  await Hive.openBox<HiveArticleData>('HiveArticlesData01');

  Hive.registerAdapter(HiveArticlesCommentsAdapter());
  await Hive.openBox<HiveArticlesComments>('HiveArticlesComments01');

  Vx.setPathUrlStrategy();
  Vx.isWeb;
  runApp(App());
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      backButtonDispatcher: RootBackButtonDispatcher(),
      title: 'Journz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Color(0xFFF7F8F9),
      ),
      routeInformationParser: VxInformationParser(),
      routerDelegate: VxNavigator(
          routes: {
            "": (uri, params) {
              var type = uri.queryParameters['Page'];
              var id = uri.queryParameters['id'];
              if (type == "/Articles") {
                return MaterialPage(
                    child: PassToArticleScreen(
                        documentId: id, articleData: params));
              } else if (type == "/PrivacyPolicy") {
                return const MaterialPage(child: PrivacyPolicy());
              } else if (type == "/Marketing") {
                return MaterialPage(child: MarketingScreen());
              } else if (type == "/ContactUs") {
                return const MaterialPage(child: ContactUs());
              } else {
                return MaterialPage(
                    child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => CheckuserloginedCubit()),
                    BlocProvider(create: (context) => GetArticleSubtypeCubit()),
                    BlocProvider(
                        create: (context) =>
                            ShowCurrentlySelectedSubtypeCubit()),
                    BlocProvider(
                        create: (context) => GetArticlesFromCloudCubit()),
                    BlocProvider(
                        create: (context) => ShowHideLoginPasswordCubit()),
                  ],
                  child: Home(
                    wantSearchBar: true,
                  ),
                ));
              }
            },

            //MyRoutes.homeRoute: (_, __) => const MaterialPage(child: HomePage()),
            MyRoutes.homeRoute: (uri, params) {
              var type = uri.queryParameters['Page'];
              var id = uri.queryParameters['id'];
              if (type == "/Articles") {
                return MaterialPage(
                    child: PassToArticleScreen(
                  documentId: id,
                  articleData: params,
                ));
              } else if (type == "/PrivacyPolicy") {
                return const MaterialPage(child: PrivacyPolicy());
              } else if (type == "/Marketing") {
                return MaterialPage(child: MarketingScreen());
              } else if (type == "/ContactUs") {
                return const MaterialPage(child: ContactUs());
              } else {
                return MaterialPage(
                    child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => CheckuserloginedCubit()),
                    BlocProvider(create: (context) => GetArticleSubtypeCubit()),
                    BlocProvider(
                        create: (context) =>
                            ShowCurrentlySelectedSubtypeCubit()),
                    BlocProvider(
                        create: (context) => GetArticlesFromCloudCubit()),
                    BlocProvider(
                        create: (context) => ShowHideLoginPasswordCubit()),
                  ],
                  child: Home(
                    wantSearchBar: true,
                  ),
                ));
              }
            },
            /* MyRoutes.privacyPolicy: (uri, __) =>
            const MaterialPage(child: PrivacyPolicy()) */
          },
          notFoundPage: (uri, param) => MaterialPage(
                  child: Scaffold(
                body: Center(
                  child: Text('Page Not Found'),
                ),
              ))),
      //home: const HomePage(),
    );
  }
}

class PassToArticleScreen extends StatefulWidget {
  final documentId;
  final articleData;
  const PassToArticleScreen(
      {Key? key, required this.documentId, required this.articleData})
      : super(key: key);

  @override
  _PassToArticleScreenState createState() => _PassToArticleScreenState();
}

class _PassToArticleScreenState extends State<PassToArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CheckInternetConnectionCubit()),
        BlocProvider(create: (context) => ShowArticleDataCubit()),
        BlocProvider(create: (context) => CheckuserloginedCubit()),
        BlocProvider(create: (context) => ShowHideLoginPasswordCubit()),
      ],
      child: DetailedArticleScreen(
        data: widget.articleData,
        docId: widget.documentId,
      ),
    );
  }
}







/* 
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
} */








/*

VxNavigator(routes: {
        "/": (uri, params) => MaterialPage(
                child: BlocProvider(
              create: (context) => CheckuserloginedCubit(),
              child: PassToHome(),
            )),
        MyRoutes.homeRoute: (uri, params) => MaterialPage(
                child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => GetArticleSubtypeCubit()),
                BlocProvider(
                    create: (context) => ShowCurrentlySelectedSubtypeCubit()),
                BlocProvider(create: (context) => GetArticlesFromCloudCubit()),
                BlocProvider(create: (context) => ShowHideLoginPasswordCubit()),
              ],
              child: Home(
                wantSearchBar: true,
              ),
            )),
        MyRoutes.marketing: (uri, params) {
          return MaterialPage(child: MarketingScreen());
        },
        MyRoutes.privacyPolicy: (uri, param) {
          print('nnn uri $uri');
          return VxRoutePage(
              child: PrivacyPolicy(),
              pageName: "Privacy Policy",
              transition: (animation, child) => ScaleTransition(
                    alignment: Alignment.bottomLeft,
                    scale: Tween(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(
                      CurvedAnimation(
                          parent: animation, curve: Curves.easeInOut),
                    ),
                    child: child,
                  ));
        },
        MyRoutes.contactUs: (uri, params) {
          return MaterialPage(child: ContactUs());
        },
        MyRoutes.articleScreen: (uri, params) {
          return MaterialPage(
              child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => CheckuserloginedCubit()),
              BlocProvider(create: (context) => ShowHideLoginPasswordCubit()),
            ],
            child: DetailedArticleScreen(hiveData: params),
          ));
        },
      }), */