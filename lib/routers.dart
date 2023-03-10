import 'package:ai_ecard/pages/chat/chat_controller.dart';
import 'package:ai_ecard/pages/chat/chat_page.dart';
import 'package:ai_ecard/pages/home/detail/page.dart';
import 'package:ai_ecard/pages/home/home_controller.dart';
import 'package:ai_ecard/pages/home/home_page.dart';
import 'package:ai_ecard/pages/image_editor/controller.dart';
import 'package:ai_ecard/pages/image_editor/page.dart';
import 'package:ai_ecard/pages/login/login_controller.dart';
import 'package:ai_ecard/pages/login/login_page.dart';
import 'package:ai_ecard/pages/start/page.dart';
import 'package:ai_ecard/pages/start/start_controller.dart';
import 'package:ai_ecard/pages/start/start_page.dart';
import 'package:ai_ecard/service/chat/chat_service.dart';
import 'package:ai_ecard/splash_screen.dart';
import 'package:get/get.dart';

import 'pages/generate/controller.dart';
import 'pages/generate/page.dart';
import 'pages/home/detail/controller.dart';
import 'service/generate/generate_service.dart';
import 'widgets/scaffold_default.dart';

class AppRoutes{
  AppRoutes._();
  static String initRouter = '/';
  static String start = '/start';
  static String login = '/login';
  static String home = '/home';
  static String chat = '/chat';
  static String imageEditor = '/image_editor';
  static String generateImage = '/generate_image';
  static String homeDetail = '/home_detail';
  static String homeDefault = '/home_default';
  static List<GetPage> createRoutes = [
    GetPage(
        name: initRouter,
        binding: BindingsBuilder(() {
        }),
        page: () => const SplashScreen()
    ),
    GetPage(
        name: login,
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoginController());
        }),
        page: () => const LoginPage(),
    ),
    GetPage(
        name: home,
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HomeController());
        }),
        page: () => const HomePage()
    ),
    GetPage(
        name: chat,
        binding: BindingsBuilder(() {
          Get.lazyPut(()=>ChatService());
          Get.lazyPut(() => ChatController(Get.find()));
        }),
        page: () => const ChatPage()
    ),
    GetPage(
        name: imageEditor,
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ImageEditorController());
        }),
        page: () =>  const ImageEditorPage()
    ),GetPage(
        name: generateImage,
        binding: BindingsBuilder(() {
          Get.lazyPut(()=>GenerateService());
          Get.lazyPut(()=>GenerateController(Get.find()));
        }),
        page: () =>  const GenerateEdit()
    ),
    GetPage(
      name: start,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
      page: () => StartPage(),
    ),
    GetPage(
        name: homeDetail,
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HomeDetailController());
        }),
        page: () => const HomeDetailPage(),
    ),
    GetPage(
        name: homeDefault,
        binding: BindingsBuilder(() {
        }),
        page: () => const ScaffoldDefault(),
    ),
  ];
}
