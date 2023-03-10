import 'dart:io';

import 'package:ai_ecard/evn.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/service/localization_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'import.dart';

void mainDelegate(Environment evn) async {
AppEnvironment.setAppEnvironment(evn);
WidgetsFlutterBinding.ensureInitialized();
HttpOverrides.global = MyHttpOverrides();
MobileAds.instance.initialize();
runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
        ));
    return ScreenUtilInit(
      designSize: const Size(375, 821),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'app_title'.tr,
            getPages: AppRoutes.createRoutes,
            initialRoute: AppRoutes.initRouter,
            locale: LocalizationService.locale,
            translations: LocalizationService(),
            builder: botToastBuilder
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}