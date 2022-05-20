import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journz_web/Journz_Large_Screen/Add_Articles/Screen/show_articles_under_review.dart';
import 'package:journz_web/Journz_Large_Screen/Add_Articles/Screen/show_rejected_articles.dart';
import 'package:journz_web/Journz_Large_Screen/NewHomePage/Cubits/ShowCountryCodeAtSignUpUiCubit/show_country_code_at_signup_ui_cubit.dart';
import 'package:journz_web/Journz_Large_Screen/NewHomePage/Page/responsive_home_page.dart';
import 'package:journz_web/Journz_Mobile/Authentication/Cubits/LoginCubit/login_cubit.dart';
import 'package:journz_web/Journz_Mobile/Authentication/Cubits/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import 'package:journz_web/Journz_Mobile/Authentication/Cubits/ShowhidepasswordInsignup/showhidepasswordinsignup_cubit.dart';
import 'package:journz_web/Journz_Mobile/Authentication/Cubits/SignupCheckboxCubit/signupcheckbox_cubit.dart';
import 'package:journz_web/Journz_Mobile/Authentication/Cubits/showHideReEnterPasswordCubit/showhidepassword_cubit.dart';
import 'package:journz_web/Journz_Mobile/Authentication/Screen/mobile_login_screen.dart';
import 'package:journz_web/Journz_Mobile/Authentication/Screen/mobile_signup_screen.dart';
import 'package:journz_web/Journz_Mobile/Authentication/Screen/mobile_signup_success.dart';
import 'package:journz_web/Journz_Mobile/Personal_Articles/mobile_articles_under_review.dart';
import 'package:journz_web/Journz_Mobile/Personal_Articles/mobile_rejected_articles.dart';
import 'package:journz_web/Journz_Mobile/UserProfile/mobile_user_profile_edit_screen.dart';
import 'package:journz_web/Journz_Tab/Authentication/Screen/tab_signup_screen.dart';
import 'package:journz_web/Journz_Tab/Authentication/Screen/tab_signup_success.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Journz_Large_Screen/Add_Articles/Screen/show_published_articles.dart';
import 'Journz_Large_Screen/Add_Articles/Screen/show_saved_articles.dart';
import 'Journz_Large_Screen/Add_Articles/cubits/AddPhotoToArticle/addphototoarticle_cubit.dart';
import 'Journz_Large_Screen/Add_Articles/cubits/get_saved_articles_cubit/get_bookmarked_articles_cubit.dart';
import 'Journz_Large_Screen/Add_Articles/cubits/get_subtype_in_article_creation_cubit/get_subtype_in_article_creation_cubit.dart';
import 'Journz_Large_Screen/Add_Articles/cubits/stepper_cubit/stepper_cubit.dart';

import 'Journz_Large_Screen/Articles/Comments/hive_articles_comments.dart';
import 'Journz_Large_Screen/Articles/Cubit/ShowArticleData/show_article_data_cubit.dart';
import 'Journz_Large_Screen/Articles/Cubit/ShowCommentCubit/show_comment_cubit.dart';
import 'Journz_Large_Screen/Articles/Cubit/bookmark_articles_cubit/bookmarkarticles_cubit.dart';
import 'Journz_Large_Screen/Articles/Page/detailed_article_screen.dart';
import 'Journz_Large_Screen/Common/Cubits/CheckInternetConnection/check_internet_connection_cubit.dart';
import 'Journz_Large_Screen/Common/Cubits/Show_Loading_Screen_Cubit.dart/show_loading_screen_cubit.dart';

import 'Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import 'Journz_Large_Screen/HiveArticlesModel/GetArticlesFromCloud/get_articles_from_cloud_cubit.dart';
import 'Journz_Large_Screen/NewHomePage/Components/user_profile_edit_screen.dart';

import 'Journz_Large_Screen/NewHomePage/Cubits/ShowHideLoginPasswordCubit/show_hide_login_password_cubit.dart';
import 'Journz_Large_Screen/NewHomePage/Cubits/gender_cubit/pass_gender_cubit_cubit.dart';
import 'Journz_Large_Screen/NewHomePage/Cubits/get_articles_subtype_cubit/get_article_subtype_cubit.dart';
import 'Journz_Large_Screen/NewHomePage/Cubits/leftpane_expansiontile_cubit/leftpane_expansion_tile_cubit.dart';
import 'Journz_Large_Screen/NewHomePage/Cubits/marital_status_cubit/marital_status_cubit.dart';
import 'Journz_Large_Screen/NewHomePage/Cubits/notification_on_off_cubit/notificationonoff_cubit.dart';

import 'Journz_Large_Screen/UserProfile/Screen/user_profile_screen.dart';

import 'Journz_Large_Screen/utils/routes.dart';

import 'package:velocity_x/velocity_x.dart';
import 'dart:html' as html;
import 'Journz_Large_Screen/Add_Articles/Screen/new_article_creation_screen.dart';
import 'Journz_Large_Screen/Add_Articles/cubits/AddLinkUrlCubit/add_link_url_cubit.dart';
import 'Journz_Large_Screen/Add_Articles/cubits/render_author_name_cubit/render_author_name_cubit.dart';
import 'Journz_Large_Screen/Add_Articles/cubits/render_selected_subtype_name_cubit/render_selected_subtype_name_cubit.dart';
import 'Journz_Large_Screen/NewHomePage/ContactUs/Screen/contact_us.dart';
import 'Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'Journz_Large_Screen/NewHomePage/LocalDatabase/HiveArticleSubtypeModel/hive_article_subtype_model.dart';
import 'Journz_Large_Screen/NewHomePage/Marketing/Screen/MarketingScreen.dart';
import 'Journz_Large_Screen/NewHomePage/PrivacyPolicy/Screen/privacypolicy.dart';
import 'Journz_Mini_Desktop/Article_Reading_Screen/mini_desktop_detailed_article_screen.dart';
import 'Journz_Mobile/Article_Creation/mobile_article_creation.dart';
import 'Journz_Mobile/Article_Reading_Screen/mobile_detailed_article_screen.dart';
import 'Journz_Mobile/Personal_Articles/mobile_personal_articles.dart';
import 'Journz_Mobile/Saved_Articles/mobile_saved_articles.dart';
import 'Journz_Mobile/UserProfile/mobile_user_profile.dart';
import 'Journz_Tab/Article_Reading_Screen/tab_detailed_article_screen.dart';
import 'Journz_Tab/Authentication/Screen/tab_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  await Hive.initFlutter();

  Hive.registerAdapter(HiveArticlesSubtypesAdapter());
  await Hive.openBox<HiveArticlesSubtypes>('HiveArticlesSubtype01');

  Hive.registerAdapter(HiveArticleDataAdapter());
  await Hive.openBox<HiveArticleData>('HiveArticlesData01');

  Hive.registerAdapter(HiveArticlesCommentsAdapter());
  await Hive.openBox<HiveArticlesComments>('HiveArticlesComments01');

  Vx.setPathUrlStrategy();
  Vx.isWeb;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.data["webUrl"].split("https://").length == 1) {
      launch("https://${message.data["webUrl"]}");
    } else {
      launch(message.data["webUrl"]);
    }
  });

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
          return MultiBlocProvider(providers: [
            BlocProvider(create: (context) => GetArticleSubtypeCubit()),
            BlocProvider(create: (context) => GetArticlesFromCloudCubit()),
          ], child: MyApp());
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
  void didChangeDependencies() {
    print("nnn url state ${html.window.location.href}");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("nnn Prime Building");
    context.read<GetArticleSubtypeCubit>().addSubtypeToHiveDb();
    context.read<GetArticlesFromCloudCubit>().getArticlesfromCloud();
    return MaterialApp.router(
      scrollBehavior: MyCustomScrollBehavior(),
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
              } else if (type == "/PersonalArticles") {
                return MaterialPage(
                  child: ResponsivePersonalArticles(),
                );
              } else if (type == "/ArticlesUnderReview") {
                return MaterialPage(
                  child: ResponsiveArticlesUnderReview(),
                );
              } else if (type == "/RejectedArticles") {
                return MaterialPage(
                  child: ResponsiveRejectedArticles(),
                );
              } else if (type == "/SavedArticles") {
                return MaterialPage(child: ResponsiveSavedArticles());
              } else if (type == "/UserProfile") {
                return MaterialPage(child: ResponsiveUserProfile());
              } else if (type == "/UserProfile/EditProfile") {
                return MaterialPage(
                    child: ResponsiveUserProfileEditScreen(params: params));
              } else if (type == "/PrivacyPolicy") {
                return const MaterialPage(child: PrivacyPolicy());
              } else if (type == "/Marketing") {
                return MaterialPage(child: MarketingScreen());
              } else if (type == "/ContactUs") {
                return const MaterialPage(child: ContactUs());
              } else if (type == "/SignUpSuccess") {
                return const MaterialPage(child: ResponsiveSignUpSuccess());
              } else if (type == "/Login") {
                return MaterialPage(child: ResponsiveLogin());
              } else if (type == "/SignUp") {
                return MaterialPage(child: ResponsiveSignUp());
              } else if (type == "/CreateArticle") {
                return MaterialPage(
                    child: ResponsiveCreateArticle(params: params));
              } else {
                return MaterialPage(
                    child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => NotificationonoffCubit()),
                    BlocProvider(
                        create: (context) => LeftpaneExpansionTileCubit()),
                    BlocProvider(create: (context) => CheckuserloginedCubit()),
                    BlocProvider(create: (context) => GetArticleSubtypeCubit()),
                    BlocProvider(create: (context) => ShowLoadingScreenCubit()),
                    BlocProvider(
                        create: (context) => GetArticlesFromCloudCubit()),
                    BlocProvider(
                        create: (context) => ShowHideLoginPasswordCubit()),
                  ],
                  child:
                      ResponsiveHomePage(showFavCategoryname: params ?? "All"),
                ));
              }
            },
            MyRoutes.homeRoute: (uri, params) {
              var type = uri.queryParameters['Page'];
              var id = uri.queryParameters['id'];
              if (type == "/Articles") {
                return MaterialPage(
                    child: PassToArticleScreen(
                  documentId: id,
                  articleData: params,
                ));
              } else if (type == "/PersonalArticles") {
                return MaterialPage(
                  child: ResponsivePersonalArticles(),
                );
              } else if (type == "/ArticlesUnderReview") {
                return MaterialPage(
                  child: ResponsiveArticlesUnderReview(),
                );
              } else if (type == "/RejectedArticles") {
                return MaterialPage(
                  child: ResponsiveRejectedArticles(),
                );
              } else if (type == "/UserProfile/EditProfile") {
                return MaterialPage(
                    child: ResponsiveUserProfileEditScreen(params: params));
              } else if (type == "/UserProfile") {
                return MaterialPage(child: ResponsiveUserProfile());
              } else if (type == "/SavedArticles") {
                return MaterialPage(
                  child: ResponsiveSavedArticles(),
                );
              } else if (type == "/PrivacyPolicy") {
                return const MaterialPage(child: PrivacyPolicy());
              } else if (type == "/Marketing") {
                return MaterialPage(child: MarketingScreen());
              } else if (type == "/ContactUs") {
                return const MaterialPage(child: ContactUs());
              } else if (type == "/SignUpSuccess") {
                return const MaterialPage(child: ResponsiveSignUpSuccess());
              } else if (type == "/Login") {
                return MaterialPage(child: ResponsiveLogin());
              } else if (type == "/SignUp") {
                return MaterialPage(child: ResponsiveSignUp());
              } else if (type == "/CreateArticle") {
                return MaterialPage(
                    child: ResponsiveCreateArticle(params: params));
              } else {
                return MaterialPage(
                    child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => NotificationonoffCubit()),
                    BlocProvider(
                        create: (context) => LeftpaneExpansionTileCubit()),
                    BlocProvider(create: (context) => CheckuserloginedCubit()),
                    BlocProvider(create: (context) => GetArticleSubtypeCubit()),
                    BlocProvider(
                        create: (context) => GetArticlesFromCloudCubit()),
                    BlocProvider(
                        create: (context) => ShowHideLoginPasswordCubit()),
                  ],
                  child:
                      ResponsiveHomePage(showFavCategoryname: params ?? "All"),
                ));
              }
            },
            "/firebase-messaging-sw.js/": (uri, params) {
              var type = uri.queryParameters['Page'];
              var id = uri.queryParameters['id'];

              if (type == "/Articles") {
                return MaterialPage(
                    child: PassToArticleScreen(
                        documentId: id, articleData: params));
              } else {
                return MaterialPage(
                    child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => NotificationonoffCubit()),
                    BlocProvider(
                        create: (context) => LeftpaneExpansionTileCubit()),
                    BlocProvider(create: (context) => CheckuserloginedCubit()),
                    BlocProvider(create: (context) => GetArticleSubtypeCubit()),
                    BlocProvider(create: (context) => ShowLoadingScreenCubit()),
                    BlocProvider(
                        create: (context) => GetArticlesFromCloudCubit()),
                    BlocProvider(
                        create: (context) => ShowHideLoginPasswordCubit()),
                  ],
                  child:
                      ResponsiveHomePage(showFavCategoryname: params ?? "All"),
                ));
              }
            },
          },
          notFoundPage: (uri, param) => MaterialPage(
                  child: Scaffold(
                body: Center(
                  child: Text('Page Not Found'),
                ),
              ))),
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
          BlocProvider(create: (context) => NotificationonoffCubit()),
          BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
          BlocProvider(create: (context) => BookmarkarticlesCubit()),
          BlocProvider(create: (context) => ShowCommentCubit()),
          BlocProvider(create: (context) => CheckInternetConnectionCubit()),
          BlocProvider(create: (context) => ShowArticleDataCubit()),
          BlocProvider(create: (context) => CheckuserloginedCubit()),
          BlocProvider(create: (context) => ShowHideLoginPasswordCubit()),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1200) {
              print("Laptop");
              return DetailedArticleScreen(
                data: widget.articleData,
                docId: widget.documentId,
              );
            } else if (constraints.maxWidth > 850) {
              print("Mini Desktop");
              return MiniDesktopDetailedArticleScreen(
                data: widget.articleData,
                docId: widget.documentId,
              );
            } else if (constraints.maxWidth > 550) {
              print("Tab");
              return TabDetailedArticleScreen(
                data: widget.articleData,
                docId: widget.documentId,
              );
            } else {
              print("Mobile");
              return MobileDetailedArticleScreen(
                data: widget.articleData,
                docId: widget.documentId,
              );
            }
          },
        ));
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class ResponsivePersonalArticles extends StatelessWidget {
  const ResponsivePersonalArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1200) {
              print("Laptop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowPersonalArticles());
            } else if (constraints.maxWidth > 769) {
              print("Mini Desktop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowPersonalArticles());
            } else if (constraints.maxWidth > 481) {
              print("Tab");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowPersonalArticles());
            } else {
              print("Mobile");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: MobileShowPersonalArticles());
            }
          },
        ),
      ),
    );
  }
}

class ResponsiveArticlesUnderReview extends StatelessWidget {
  const ResponsiveArticlesUnderReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1200) {
              print("Laptop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowArticlesUnderReview());
            } else if (constraints.maxWidth > 769) {
              print("Mini Desktop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowArticlesUnderReview());
            } else if (constraints.maxWidth > 481) {
              print("Tab");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowArticlesUnderReview());
            } else {
              print("Mobile");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: MobileShowArticlesUnderReview());
            }
          },
        ),
      ),
    );
  }
}

class ResponsiveRejectedArticles extends StatelessWidget {
  const ResponsiveRejectedArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1200) {
              print("Laptop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowrejectedArticles());
            } else if (constraints.maxWidth > 769) {
              print("Mini Desktop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowrejectedArticles());
            } else if (constraints.maxWidth > 481) {
              print("Tab");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowrejectedArticles());
            } else {
              print("Mobile");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: MobileShowRejectedArticles());
            }
          },
        ),
      ),
    );
  }
}

class ResponsiveSavedArticles extends StatelessWidget {
  const ResponsiveSavedArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1200) {
              print("Laptop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => GetBookmarkedArticlesCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowSavedArticles());
            } else if (constraints.maxWidth > 769) {
              print("Mini Desktop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => GetBookmarkedArticlesCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowSavedArticles());
            } else if (constraints.maxWidth > 481) {
              print("Tab");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => GetBookmarkedArticlesCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: ShowSavedArticles());
            } else {
              print("Mobile");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => GetBookmarkedArticlesCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: MobileShowSavedArticles());
            }
          },
        ),
      ),
    );
  }
}

class ResponsiveLogin extends StatelessWidget {
  const ResponsiveLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 481) {
              print("Tab");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => LoginCubit()),
                BlocProvider(create: (context) => ShowLoadingScreenCubit()),
                BlocProvider(create: (context) => ShowhidepasswordCubit()),
              ], child: TabLoginScreen());
            } else {
              print("Mobile");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => LoginCubit()),
                BlocProvider(create: (context) => ShowLoadingScreenCubit()),
                BlocProvider(create: (context) => ShowhidepasswordCubit()),
              ], child: MobileLoginScreen());
            }
          },
        ),
      ),
    );
  }
}

class ResponsiveSignUp extends StatelessWidget {
  const ResponsiveSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 481) {
              print("Tab");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => ShowLoadingScreenCubit()),
                BlocProvider(create: (context) => SignupcheckboxCubit()),
                BlocProvider(
                    create: (context) => ShowCountryCodeAtSignupUiCubit()),
                BlocProvider(
                    create: (context) => ShowHideReEnterPasswordCubit()),
                BlocProvider(
                    create: (context) => ShowhidepasswordinsignupCubit()),
              ], child: MobileSignupScreen());
            } else {
              print("Mobile");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => ShowLoadingScreenCubit()),
                BlocProvider(create: (context) => SignupcheckboxCubit()),
                BlocProvider(
                    create: (context) => ShowCountryCodeAtSignupUiCubit()),
                BlocProvider(
                    create: (context) => ShowHideReEnterPasswordCubit()),
                BlocProvider(
                    create: (context) => ShowhidepasswordinsignupCubit()),
              ], child: MobileSignupScreen());
            }
          },
        ),
      ),
    );
  }
}

class ResponsiveSignUpSuccess extends StatelessWidget {
  const ResponsiveSignUpSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 481) {
              print("Tab");
              return TabSignupSuccess();
            } else {
              print("Mobile");
              return MobileSignupSuccess();
            }
          },
        ),
      ),
    );
  }
}

class ResponsiveCreateArticle extends StatelessWidget {
  final Map<String, dynamic> params;
  const ResponsiveCreateArticle({Key? key, required this.params})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1200) {
              print("Laptop");
              return MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => NotificationonoffCubit()),
                    BlocProvider(
                        create: (context) => LeftpaneExpansionTileCubit()),
                    BlocProvider(
                        create: (context) =>
                            GetSubtypeInArticleCreationCubit()),
                    BlocProvider(create: (context) => CheckuserloginedCubit()),
                    BlocProvider(create: (context) => AddphotoarticleCubit()),
                    BlocProvider(
                        create: (context) => RenderSelectedSubtypeNameCubit()),
                    BlocProvider(create: (context) => StepperCubit()),
                    BlocProvider(create: (context) => RenderAuthorNameCubit()),
                    BlocProvider(create: (context) => AddLinkUrlCubit()),
                  ],
                  child: NewArticleCreationScreen(
                      IsEditArticle: params['isEditArticle'],
                      articleData: params['articleData']));
            } else if (constraints.maxWidth > 769) {
              print("Mini Desktop");
              return MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => NotificationonoffCubit()),
                    BlocProvider(
                        create: (context) => LeftpaneExpansionTileCubit()),
                    BlocProvider(
                        create: (context) =>
                            GetSubtypeInArticleCreationCubit()),
                    BlocProvider(create: (context) => CheckuserloginedCubit()),
                    BlocProvider(create: (context) => AddphotoarticleCubit()),
                    BlocProvider(
                        create: (context) => RenderSelectedSubtypeNameCubit()),
                    BlocProvider(create: (context) => StepperCubit()),
                    BlocProvider(create: (context) => RenderAuthorNameCubit()),
                    BlocProvider(create: (context) => AddLinkUrlCubit()),
                  ],
                  child: NewArticleCreationScreen(
                      IsEditArticle: params['isEditArticle'],
                      articleData: params['articleData']));
            } else if (constraints.maxWidth > 481) {
              print("Tab");
              return MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => NotificationonoffCubit()),
                    BlocProvider(
                        create: (context) => LeftpaneExpansionTileCubit()),
                    BlocProvider(
                        create: (context) =>
                            GetSubtypeInArticleCreationCubit()),
                    BlocProvider(create: (context) => CheckuserloginedCubit()),
                    BlocProvider(create: (context) => AddphotoarticleCubit()),
                    BlocProvider(
                        create: (context) => RenderSelectedSubtypeNameCubit()),
                    BlocProvider(create: (context) => StepperCubit()),
                    BlocProvider(create: (context) => RenderAuthorNameCubit()),
                    BlocProvider(create: (context) => AddLinkUrlCubit()),
                  ],
                  child: NewArticleCreationScreen(
                      IsEditArticle: params['isEditArticle'],
                      articleData: params['articleData']));
            } else {
              print("Mobile");
              return MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => NotificationonoffCubit()),
                    BlocProvider(
                        create: (context) => LeftpaneExpansionTileCubit()),
                    BlocProvider(
                        create: (context) =>
                            GetSubtypeInArticleCreationCubit()),
                    BlocProvider(create: (context) => CheckuserloginedCubit()),
                    BlocProvider(create: (context) => AddphotoarticleCubit()),
                    BlocProvider(
                        create: (context) => RenderSelectedSubtypeNameCubit()),
                    BlocProvider(create: (context) => StepperCubit()),
                    BlocProvider(create: (context) => RenderAuthorNameCubit()),
                    BlocProvider(create: (context) => AddLinkUrlCubit()),
                  ],
                  child: MobileArticleCreationScreen(
                      IsEditArticle: params['isEditArticle'],
                      articleData: params['articleData']));
            }
          },
        ),
      ),
    );
  }
}

class ResponsiveUserProfile extends StatelessWidget {
  const ResponsiveUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1200) {
              print("Laptop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: UserProfileScreen());
            } else if (constraints.maxWidth > 769) {
              print("Mini Desktop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: UserProfileScreen());
            } else if (constraints.maxWidth > 481) {
              print("Tab");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: UserProfileScreen());
            } else {
              print("Mobile");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
              ], child: MobileUserProfileScreen());
            }
          },
        ),
      ),
    );
  }
}

class ResponsiveUserProfileEditScreen extends StatelessWidget {
  final Map<String, dynamic> params;
  const ResponsiveUserProfileEditScreen({Key? key, required this.params})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1200) {
              print("Laptop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
                BlocProvider(create: (context) => ShowLoadingScreenCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => PassGenderCubit()),
                BlocProvider(create: (context) => MaritalStatusCubit()),
                BlocProvider(create: (context) => AddphotoarticleCubit()),
              ], child: UserProfileEditScreen(userState: params['UserData']));
            } else if (constraints.maxWidth > 769) {
              print("Mini Desktop");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
                BlocProvider(create: (context) => ShowLoadingScreenCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => PassGenderCubit()),
                BlocProvider(create: (context) => MaritalStatusCubit()),
                BlocProvider(create: (context) => AddphotoarticleCubit()),
              ], child: UserProfileEditScreen(userState: params['UserData']));
            } else if (constraints.maxWidth > 481) {
              print("Tab");
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => NotificationonoffCubit()),
                BlocProvider(create: (context) => LeftpaneExpansionTileCubit()),
                BlocProvider(create: (context) => ShowLoadingScreenCubit()),
                BlocProvider(create: (context) => CheckuserloginedCubit()),
                BlocProvider(create: (context) => PassGenderCubit()),
                BlocProvider(create: (context) => MaritalStatusCubit()),
                BlocProvider(create: (context) => AddphotoarticleCubit()),
              ], child: UserProfileEditScreen(userState: params['UserData']));
            } else {
              print("Mobile");
              return MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => NotificationonoffCubit()),
                    BlocProvider(
                        create: (context) => LeftpaneExpansionTileCubit()),
                    BlocProvider(create: (context) => ShowLoadingScreenCubit()),
                    BlocProvider(create: (context) => CheckuserloginedCubit()),
                    BlocProvider(create: (context) => PassGenderCubit()),
                    BlocProvider(create: (context) => MaritalStatusCubit()),
                    BlocProvider(create: (context) => AddphotoarticleCubit()),
                  ],
                  child: MobileUserProfileEditScreen(
                      userState: params['UserData']));
            }
          },
        ),
      ),
    );
  }
}
