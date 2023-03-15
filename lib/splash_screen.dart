import 'package:ai_ecard/helper/file_helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/account/account_model.dart';
import 'package:ai_ecard/models/models/token/token.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/service/app_storage.dart';
import 'package:ai_ecard/service/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      TokenObj token = await UserService().getToken(AccountModel('test', '123456'));
      if(token.accessToken != null){
        AppStorage.accessToken = token.accessToken;
        Get.offAndToNamed(AppRoutes.start);
      }
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
