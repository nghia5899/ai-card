import 'dart:ffi';
import 'dart:io';

import 'package:ai_ecard/import.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {

  static String get _bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return 'ca-app-pub-3940256099942544/6300978111';
  }

  static String get _interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/8691691433';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/8691691433';
    }
    return 'ca-app-pub-3940256099942544/8691691433';
  }

  static BannerAdListener _bannerAdListener(Function() onLoaded) {
    return BannerAdListener(
        onAdLoaded: (ad) => onLoaded.call(),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('ad failed to load: $error');
        },
        onAdOpened: (ad) => debugPrint('Ad opened'),
        onAdClosed: (ad) => debugPrint('Ad closed')
    );
  }

  static InterstitialAdLoadCallback _interstitialAdLoadCallback(Function(InterstitialAd) onLoaded) {
    return InterstitialAdLoadCallback(
        onAdLoaded: onLoaded,
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('ad failed to load: $error');
        }
    );
  }

  static BannerAd createBannerAd
      ({AdSize? size, required Function() onLoaded}) {
    final BannerAd bannerAd = BannerAd(
        size: size ?? AdSize.fullBanner,
        adUnitId: _bannerAdUnitId,
        listener: _bannerAdListener(onLoaded),
        request: const AdRequest()
    );
    return bannerAd;
  }

  static void createInterstitialAd({AdSize? size, required Function(InterstitialAd) onLoaded}) {
    InterstitialAd.load(
        adUnitId: _interstitialAdUnitId,
        request: AdRequest(),
      adLoadCallback: _interstitialAdLoadCallback(onLoaded),
    );
  }

// void abc(){
//   InterstitialAd.load(adUnitId: adUnitId, request: request, adLoadCallback: adLoadCallback)
// }
}
