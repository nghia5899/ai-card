import 'dart:math';

import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/parameters/generate_params.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/service/generate/generate_service.dart';
import 'package:get/get.dart';


class GenerateImageController extends GetxController {
  Rx<String> generateImageContent = ''.obs;
  late TextEditingController textController;

  RxList<String> keywordSuggest = <String>[].obs;
  Rx<int> selectedIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    keywordSuggest.value = greetings.sublist(0, min(10, greetings.length));
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void getPrompt() async {
    try {
      showLoading();
      GenerateService service = GenerateService();
      final data = await service.passer(GenerateParameter(generateText(), 3, '1024x1024'));
      disableLoading();
      var images = data['data'];
      Get.toNamed(AppRoutes.imageViews, arguments: images);
    } catch (e) {
      disableLoading();
      showMessage('Generate image failed', type: 'FAIL');
    }
  }

  void updateContent(String? value) {
    if((value?.trimLeft().trimRight().split(' ').length ?? 0) <= 8) {
      generateImageContent.value = value ?? '';
      keywordSuggest.value = greetings.where((e) => e.toLowerCase().contains(generateImageContent.value.toLowerCase())).toList();
      selectedIndex.value = -1;
    } else {
      textController.text = generateImageContent.value;
    }
  }

  void updateSelectedItem(int index) {
    if(selectedIndex.value == index) {
      selectedIndex.value = -1;
    }
    else {
      selectedIndex.value = index;
    }
    selectedIndex.refresh();
  }

  void clearText() {
    textController.text = '';
    updateContent('');
  }

  String generateText() {
    if (selectedIndex.value >= 0) {
      return keywordSuggest[selectedIndex.value];
    } else {
      return '';
    }
  }

  Rx<int> get words => generateImageContent.value.isNotEmpty ? generateImageContent.value.trimLeft().trimRight().split(' ').length.obs : 0.obs;

}
