import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/parameters/generate_params.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/service/generate/generate_service.dart';

class GenerateImageController extends GetxController {
  Rx<String> generateImageContent = ''.obs;
  late TextEditingController textController;

  List<String> keywordSuggest = [
    'Concept art',
    'Illustration',
    'Illustration',
    'Ultra-realistic',
    'Digital art',
    'Portrait',
    'Full HD',
    'HD',
    '8K',
    '4K',
    'High resolution',
  ];

  @override
  void onInit(){
    super.onInit();
    textController = TextEditingController();
  }

  @override
  void dispose(){
    textController.dispose();
    super.dispose();


  }

  RxList<bool> selectItem = [false, false, false, false, false, false, false, false, false, false, false].obs;

  void getPrompt() async {
    showLoading();
    GenerateService service = GenerateService();
    final data = await service.passer(GenerateParameter(generateImageContent.value, 1024, 1024, 'Painting'));
    disableLoading();
    var images = data['images'];
    Get.toNamed(AppRoutes.imageViews, arguments: images);
  }

  void updateContent(String? value) {
    generateImageContent.value = value ?? '';
  }

  void updateSelectedItem(int index) {
    selectItem[index] = !selectItem[index];
    selectItem.refresh();
  }

  void clearText(){
    textController.text = '';
    updateContent('');
  }

}
