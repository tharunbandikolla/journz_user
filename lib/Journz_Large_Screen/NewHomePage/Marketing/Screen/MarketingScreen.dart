import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// ignore: must_be_immutable
class MarketingScreen extends StatefulWidget {
  MarketingScreen({Key? key}) : super(key: key);

  @override
  State<MarketingScreen> createState() => _MarketingScreenState();
}

class _MarketingScreenState extends State<MarketingScreen> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'baln2rRKyJ0',
    params: YoutubePlayerParams(
      startAt: Duration.zero,
      autoPlay: true,
      loop: true,
      strictRelatedVideos: true,
      showControls: false,
      showFullscreenButton: false,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.vxNav.replace(Uri(path: '/'));
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const HomePage()));
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              context.vxNav.popToRoot();
            },
            child: Image.asset(
              'assets/images/journzlogo1.png',
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue.shade400,
          title: InkWell(
              onTap: () {
                context.vxNav.popToRoot();
              },
              child: "JOURNZ".text.bold.white.xl2.make()),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: context.screenWidth,
            child: Column(
              children: [
                SizedBox(
                  height: context.screenWidth * 0.025,
                ),
                Container(
                  width: context.screenWidth * 0.7,
                  height: context.screenHeight * 0.7,
                  child: YoutubePlayerControllerProvider(
                    // Provides controller to all the widget below it.
                    controller: _controller,
                    child: YoutubePlayerIFrame(),
                  ),
                ),
                Text('Our aim is to give you a "Journal of Your Lifetime Journey" Our intention is to provide everyone with good content. for an author Its not about how famous is the author, its about how good the content is what matters to us.for the users Maybe we are doing for the 1st time or maybe someone had done before us but our way is you don\'t follow the author, you only follow the best content. And we want to make sure to provide you the best content.')
                    .text
                    .xl3
                    .justify
                    .make()
                    .box
                    .p32
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
