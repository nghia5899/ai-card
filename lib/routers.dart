import 'package:ai_ecard/pages/chat/chat_controller.dart';
import 'package:ai_ecard/pages/chat/chat_page.dart';
import 'package:ai_ecard/pages/home/home_controller.dart';
import 'package:ai_ecard/pages/home/home_page.dart';
import 'package:ai_ecard/pages/image_editor/page.dart';
import 'package:ai_ecard/pages/login/login_controller.dart';
import 'package:ai_ecard/pages/login/login_page.dart';
import 'package:ai_ecard/service/chat/chat_service.dart';
import 'package:ai_ecard/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes{
  AppRoutes._();
  static String initRouter = '/';
  static String login = '/login';
  static String home = '/home';
  static String chat = '/chat';
  static String imageEditor = '/image_editor';
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
          Get.lazyPut(() => HomeController());
        }),
        page: () => const ImageEditorPage()
    ),
  ];
}
