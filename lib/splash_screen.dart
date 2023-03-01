import 'package:ai_ecard/config/lang/en_us.dart';
import 'package:ai_ecard/models/token/token.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/utils/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Future.delayed(const Duration(seconds: 2), () async {
      //   TokenObj? tokenObj = await SecureStorageService.getTokenObj();
      //   if (tokenObj != null && tokenObj.accessToken != null) {
      //     Get.toNamed(AppRoutes.home);
      //   } else {
      //     Get.toNamed(AppRoutes.login);
      //   }
      // });
      Get.toNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Text('app_title'.tr),
      ),
    );
  }

// void initSize() {
//   Size size = MediaQuery.of(context).size;
//   ConstantSize.screenWidth = size.width;
//   ConstantSize.screenHeight = size.height;
//   ConstantSize.isSmallScreen = ConstantSize.screenWidth <= 380; // if is a small phone return true
//   ConstantSize.isMobile = ConstantSize.screenWidth < 600; // if is a ipad return false
//   ConstantSize.isLargeScreen = size.width > 600 ? true : false;
//   if (ConstantSize.screenWidth < 380) {
//     ConstantSize.spaceMargin = 10;
//   } else {
//     ConstantSize.spaceMargin = 20;
//   }
// }
}
