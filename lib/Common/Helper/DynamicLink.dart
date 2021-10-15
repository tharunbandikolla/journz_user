import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MyHomePage(),
        '/helloWorld': (BuildContext context) => HelloWorldScreen(),
        '/detailView': (BuildContext context) => DetailViewScreen(),
      },
    );
  }
}
*/
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDynamicLinkCreated = false;
  String? linkMessage;
  String textMessage = 'Long press on the link to copy';
  List n = [];

  Future<void> initialCheck() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deeplink = dynamicLink?.link;
      if (deeplink != null) {
        var documentid = deeplink.path
            .replaceAll(RegExp("(?:-[A-Z][0-9].*)", unicode: false), "");
        var linkPath = deeplink.path.replaceAll(RegExp('(?:/helloWorld-)'), '');
        print('linkpath 99${deeplink.path}');
        print('linkpath 12 $documentid');
        print('linkpath 2 $linkPath');

//        print('linkpath 999 ${deeplink.path}');
        Navigator.of(context).pushNamed(documentid, arguments: linkPath);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      var linkPath = deepLink.path.replaceAll(RegExp('(-[A-Z])\w+'), '');
      print('linkpath 99${deepLink.path}');
      print('linkpath12 $linkPath');

      Navigator.pushNamed(context, linkPath);
    }
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      isDynamicLinkCreated = true;
    });
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://dynamiclinknavi.page.link',
        link: Uri.parse('https://dynamiclinknavi.page.link/helloWorld'),
        androidParameters: AndroidParameters(
            packageName: "com.dynamiclink.navidynamiclink", minimumVersion: 0),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
            shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: 'title of link', description: 'description'));

    Uri uri;
    if (short) {
      final ShortDynamicLink shortDynamicLink =
          await parameters.buildShortLink();
      uri = shortDynamicLink.shortUrl;
    } else {
      uri = await parameters.buildUrl();
    }
    setState(() {
      linkMessage = uri.toString();
      isDynamicLinkCreated = false;
    });
  }

  @override
  void initState() {
    initialCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: !isDynamicLinkCreated
                        ? () => _createDynamicLink(false)
                        : null,
                    child: Text('Long Link')),
                ElevatedButton(
                    onPressed: !isDynamicLinkCreated
                        ? () => _createDynamicLink(true)
                        : null,
                    child: Text('Short Link'))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  if (linkMessage != null) {
                    await launch(linkMessage!);
                  }
                },
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: linkMessage));
                },
                child: Text(
                  linkMessage ?? '',
                  style: TextStyle(color: Colors.blue),
                )),
            SizedBox(
              height: 30,
            ),
            Text(linkMessage != null ? textMessage : ''),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelloWorldScreen(),
                    ));
              },
              child: Text('pass'),
            ),
          ],
        ),
      ),
    );
  }
}

class HelloWorldScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
