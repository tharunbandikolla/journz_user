import 'package:Journz/ArticleDetailView/ArticlesDetailViewCubit/ArticleTitleCubit/articletitle_cubit.dart';
import 'package:Journz/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
import 'package:Journz/ArticleDetailView/ArticlesDetailViewCubit/CommentNumbers/commentnumbers_cubit.dart';
import 'package:Journz/Authentication/Screens/VerifyEmail.dart';
import 'package:Journz/Common/AppTheme/StartupThemePreferences.dart';
import 'package:Journz/Common/Helper/BannerAdHelper.dart';
import 'package:Journz/UserProfile/Screen/UserNotLoggedInScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/Common/Helper/AuthorRequestCubit/authorrequest_cubit.dart';
import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
import 'ArticleDetailView/ArticlesDetailViewCubit/ArticleReportCubit/articlereport_cubit.dart';
import 'ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
import 'ArticleDetailView/ArticlesDetailViewCubit/DetailViewCubit/articlesdetail_cubit.dart';
import 'ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
import 'ArticleDetailView/Screen/ArticleDetaillViewScreen.dart';
import 'Authentication/AuthenticationBloc/LoginCubit/login_cubit.dart';
import 'Authentication/AuthenticationBloc/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import 'Common/AppTheme/ThemeBloc/theme_bloc.dart';
import 'Common/AppTheme/ThemePreferenses.dart';
import 'Common/Helper/BottomNavBar/bottomnavbar_cubit.dart';
import 'Common/Helper/BottomScrollCubit/bottomscroll_cubit.dart';
import 'Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'Common/Helper/ConnectivityCubit/connectivity_cubit.dart';
import 'Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
import 'Common/Helper/SharedPrefCubitForSettingsScreen/sharedpref_cubit.dart';
import 'Common/Helper/StartupThemeHelperCubit/startupthemehelper_cubit.dart';
import 'Common/Screens/NotificationDiverter.dart';
import 'Common/Screens/StartupThemeSelection.dart';
import 'HomeScreen/Bloc/DrawerNameCubit/drawername_cubit.dart';
import 'HomeScreen/Bloc/FavouritePreferencesCubit/favouritepreference_cubit.dart';
import 'HomeScreen/Screen/HomeScreen.dart';
import 'UserProfile/Cubit/ArticlesSwapCubit/articleswap_cubit.dart';
import 'UserProfile/Screen/NewUserProfileScreen.dart';

const AndroidNotificationChannel favSubsNotificationChannel =
    AndroidNotificationChannel(
        'high_importance_channel_for_fav_subs_notification_1', // channel id
        'High Importance Notification', // title
        'This Channel is Used For Important Notifications', //desc
        importance: Importance.high,
        playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Abg message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  BannerAdsHelper.initialization();

  Preferences.init();
  // Preferences.saveTheme(AppTheme.darkTheme);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(favSubsNotificationChannel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //systemNavigationBarColor: Colors.white, // navigation bar color
  //statusBarColor: Colors.white, // status bar color
  //));
  //SystemChrome.setSystemUIOverlayStyle(
  //  SystemUiOverlayStyle(statusBarColor: Colors.white));
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var pref1;

  @override
  void initState() {
    getSharedPref();

    super.initState();
  }

  getSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref1 = pref;

    print('nnn pref $pref1');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavouritepreferenceCubit()),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => ArticlesdetailCubit()),
        BlocProvider(create: (context) => ArticlelikeCubit()),
        BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
        BlocProvider(create: (context) => ArticleswapCubit()),
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
      child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (BuildContext context, ThemeState themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeState
              .themeData! /* .copyWith(
              textTheme:
                  Theme.of(context).textTheme.apply(fontFamily: 'Tinos')) */
          ,
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => ThemeLoader(),
            '/Articles': (BuildContext context) => NotificationDiverter(),
            '/UserProfile': (BuildContext context) => NewUserProfileScreen(),
            '/VerifyEmail': (BuildContext context) => VerifyEmailScreen(),
            '/Home': (BuildContext context) => HomeScreen(curIndex: 0),
            '/MyApp': (BuildContext context) => MyApp(),
          },
        );
      }),
    );
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
    await listenForNotification();
    await initialCheck();
  }

  listenForNotification() async {
    /* FirebaseMessaging.onBackgroundMessage((message) {
      print('nnn app killed ${message.data['screen']}');
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserNotLoggedInScreen()));
    }); */
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data['screen'] == '/ArticleDetail') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                            create: (context) => DetailviewdynamiclinkCubit()),
                        BlocProvider(create: (context) => ArticlelikeCubit()),
                        BlocProvider(create: (context) => BookmarkCubit()),
                        BlocProvider(
                            create: (context) => ArticlesdetailCubit()),
                        BlocProvider(create: (context) => ArticlelikeCubit()),
                        BlocProvider(
                            create: (context) => CheckuserloginedCubit()),
                        BlocProvider(
                            create: (context) => DetailviewdynamiclinkCubit()),
                        BlocProvider(create: (context) => CommentStreamCubit()),
                        BlocProvider(create: (context) => ArticletitleCubit()),
                        BlocProvider(
                            create: (context) => CommentnumbersCubit()),
                        BlocProvider(create: (context) => ArticlereportCubit()),
                        BlocProvider(create: (context) => BookmarkCubit())
                      ],
                      child: ArticlesDetailViewScreen(
                        title: initialMessage.notification!.title,
                        fromReviewOrReject: false,
                        documentId: initialMessage
                            .data['docid'], //snapshot.data.docs[index].id,
                        fromNotification: false,
                        fromEdit: false,
                      ),
                    )));
      } else if (initialMessage.data['screen'] == '/UserProfile') {
        if (FirebaseAuth.instance.currentUser != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewUserProfileScreen()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserNotLoggedInScreen()));
        }
      }
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('nnn message $message');
      print(
          'nnn message ${message.notification}  ${message.notification?.android}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    favSubsNotificationChannel.id,
                    favSubsNotificationChannel.name,
                    favSubsNotificationChannel.description,
                    //color: Colors.red,
                    playSound: true,
                    icon: '@drawable/journzpng2')));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('on message open app ${message.data.toString()}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        if (message.data['screen'] == '/ArticleDetail') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                              create: (context) =>
                                  DetailviewdynamiclinkCubit()),
                          BlocProvider(create: (context) => ArticlelikeCubit()),
                          BlocProvider(create: (context) => BookmarkCubit()),
                          BlocProvider(
                              create: (context) => ArticlesdetailCubit()),
                          BlocProvider(create: (context) => ArticlelikeCubit()),
                          BlocProvider(
                              create: (context) => CheckuserloginedCubit()),
                          BlocProvider(
                              create: (context) =>
                                  DetailviewdynamiclinkCubit()),
                          BlocProvider(
                              create: (context) => CommentStreamCubit()),
                          BlocProvider(
                              create: (context) => ArticletitleCubit()),
                          BlocProvider(
                              create: (context) => CommentnumbersCubit()),
                          BlocProvider(
                              create: (context) => ArticlereportCubit()),
                          BlocProvider(create: (context) => BookmarkCubit())
                        ],
                        child: ArticlesDetailViewScreen(
                          title: notification.title,
                          fromReviewOrReject: false,
                          documentId: message
                              .data['docid'], //snapshot.data.docs[index].id,
                          fromNotification: false,
                          fromEdit: false,
                        ),
                      )));
        } else if (message.data['screen'] == '/UserProfile') {
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewUserProfileScreen()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserNotLoggedInScreen()));
          }
        }
        /*showDialog(
               context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });*/
      }
    });
  }

  getSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pre = pref;
    _loadTheme(pref);
    startupThemeShown = await StartupThemePreferences().getShown(pref);
    //var t = await
    if (FirebaseAuth.instance.currentUser != null) {
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

  _loadTheme(SharedPreferences preferences) {
    //print('pref theme ${Preferences.getTheme(preferences,context.read<ThemeBasedWidgetCubit>())}');
    context.read<ThemeBloc>().add(ThemeEvent(
        appTheme: Preferences.getTheme(
            preferences, context.read<ThemebasedwidgetCubit>())));
  }

  Future<void> initialCheck() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deeplink = dynamicLink?.link;
      if (deeplink != null) {
        var documentid = deeplink.queryParameters['type'];
        //.replaceAll(RegExp('(?:-[A-Za-z0-9].*)'), ''); //(?:-[A-Za-z0-9].*)
        var linkPath = deeplink.queryParameters['id'];
        //.path.replaceAll(RegExp('(?:\/Articles-)'), '');
        print('linkpath 99${deeplink.path}');
        print('linkpath 12 $documentid');
        print('linkpath 2 $linkPath');

        Navigator.of(context).pushNamed(documentid!, arguments: linkPath);
        documentid = '';
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deeplink = data?.link;
    if (deeplink != null) {
      var documentid = deeplink.queryParameters['type'];
      //.replaceAll(RegExp('(?:-[A-Za-z0-9].*)'), ''); //(?:-[A-Za-z0-9].*)
      var linkPath = deeplink.queryParameters['id'];
      //path.replaceAll(RegExp('(?:\/Articles-)'), '');
      print('linkpathe 99${deeplink.path}');
      print('linkpathe 12 $documentid');
      print('linkpathe 2 $linkPath');

      Navigator.of(context).pushNamed(documentid!, arguments: linkPath);
      documentid = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 1200))
            .then((value) => Future.value(true)),
        builder: (context, snapshot) {
          print('nnn shown or not $startupThemeShown');
          return snapshot.hasData
              ? startupThemeShown != null
                  ? BlocProvider(
                      create: (context) => SharedprefCubit(pre),
                      child: HomeScreen(curIndex: 0),
                    )
                  : MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => SharedprefCubit(pre),
                        ),
                        BlocProvider(
                          create: (context) => StartupthemehelperCubit(),
                        ),
                      ],
                      child: StartupThemeSelection(),
                    )
              : Center(
                  child: CircularProgressIndicator(
                  color: Colors.amber,
                ));
        });
  }
}
