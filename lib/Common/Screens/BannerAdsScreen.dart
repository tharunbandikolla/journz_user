import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdScreen extends StatefulWidget {
  const BannerAdScreen({Key? key}) : super(key: key);

  @override
  _BannerAdScreenState createState() => _BannerAdScreenState();
}

class _BannerAdScreenState extends State<BannerAdScreen> {
  BannerAd bAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-1237985102509408/1637081037',
      listener: BannerAdListener(onAdLoaded: (Ad ad) {
        print('Ad Loaded');
      }, onAdFailedToLoad: (Ad ad, LoadAdError err) {
        print('Ad Failed');
        print('nnnn $err');
        ad.dispose();
      }, onAdOpened: (Ad ad) {
        print('Ad opened');
      }),
      request: AdRequest());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.amber,
          width: 650,
          height: 350,
          child: AdWidget(
            ad: bAd..load(),
            key: UniqueKey(),
          ),
        ),
      ),
    );
  }
}
