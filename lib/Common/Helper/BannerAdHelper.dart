import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdsHelper {
  static String get bannerUnit => 'ca-app-pub-1237985102509408/1637081037';

  static initialization() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd getBannerAd() {
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
    return bAd;
  }
}
