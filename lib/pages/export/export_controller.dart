import 'dart:typed_data';
import 'package:get/get.dart';

class ExportController extends GetxController{
  RxList<Uint8List> stack = <Uint8List>[].obs;
  @override
  void onInit() {
    super.onInit();
    stack.add(Get.arguments as Uint8List);
  }
}