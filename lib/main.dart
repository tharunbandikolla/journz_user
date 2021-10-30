import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journz_web/Pages/detailspage.dart';
//import 'package:journz_web/Pages/homepage.dart';
import 'package:journz_web/Pages/newhomepage.dart';
import 'package:journz_web/utils/routes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  setPathUrlStrategy();
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Journz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.grey[100],
        //fontFamily: GoogleFonts.poppins().fontFamily,
        //primarySwatch: Colors.blue,
      ),
      routeInformationParser: VxInformationParser(),
      routerDelegate: VxNavigator(routes: {
        "": (_, __) => const MaterialPage(child: HomePage()),
        //MyRoutes.homeRoute: (_, __) => const MaterialPage(child: HomePage()),
        MyRoutes.homenewRoute: (uri, __) {
          //print(uri.queryParameters['id']);
          var id = uri.queryParameters['id'];
          //var type = uri.queryParameters['type'];
          return MaterialPage(
              child: DetailsPage(
            id: id!,
          ));
        }
      }),
      //home: const HomePage(),
    );
  }
}
