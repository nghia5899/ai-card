import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/service/ad_mob_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class StartController extends GetxController{
  RxBool isLoaded = false.obs;
  late BannerAd bannerAd;
  late InterstitialAd interstitialAd;
  @override
  void onInit() {
    super.onInit();
    bannerAd = AdMobService.createBannerAd(size: AdSize.fullBanner, onLoaded: () {
      isLoaded.value = true;
      isLoaded.obs;
    });
    bannerAd.load();
  }

  void reload(){
    bannerAd = AdMobService.createBannerAd(size: AdSize.fullBanner, onLoaded: () {
      isLoaded.value = true;
      isLoaded.obs;
    });
    bannerAd.load();
  }

  void showAd(){
    AdMobService.createInterstitialAd(onLoaded: (ad) async {
      interstitialAd = ad;
      await interstitialAd.show();
      Get.toNamed(AppRoutes.homeDefault);
    });
  }

  Future<void> authenticate() async {
    // LoadingProcessBuilder.showProgressDialog();
    const url = 'https://keycloak.summonersarena.io/realms/summonersarena/protocol/openid-connect/auth?client_id=saas-app&redirect_uri=saas://success&scope=openid&response_type=code&response_mode=query';
    const callbackUrlScheme = 'aiecard';

    try {
      final result = await FlutterWebAuth2.authenticate(
          url: url,
          callbackUrlScheme: callbackUrlScheme
      );
      final code = Uri.parse(result).queryParameters['code'];
      print(code);
      // // print(code);
      //   if (code != null) {
      //     bool res = await AuthService.getTokenByCode(context, code);
      //     await LoadingProcessBuilder.closeProgressDialog();
      //     if (res) {
      //       await AuthService.handleAfterLogin(context);
      //     }
      //   } else {
      //     SnackbarBuilder.showSnackbar(content: 'Login Failed!');
      //     await LoadingProcessBuilder.closeProgressDialog();
      //   }
    } on PlatformException catch (e) {
      // await LoadingProcessBuilder.closeProgressDialog();
      print(e);
    }
  }

  @override
  void onClose() {
    interstitialAd.dispose();
    super.onClose();
  }
}