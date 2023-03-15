import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/models/chat/chat_model.dart';
import 'package:ai_ecard/models/parameters/chat_params.dart';
import 'package:ai_ecard/service/chat/chat_service.dart';
import 'package:bot_toast/bot_toast.dart';

class GenerateContentController extends GetxController{
  Rx<String> generateContent = ''.obs;
  late TextEditingController textController;
  RxList<String> generateContentResult = <String>[].obs;
  final ChatService _chatService;

  GenerateContentController(this._chatService);

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
  }

  void updateContent(String? value){
    if((value ?? '').length <= 1000) {
      generateContent.value = value ?? '';
    } else {
      textController.text = generateContent.value;
    }
  }

  void clearText() {
    textController.text = '';
    updateContent('');
  }

  void getPrompt() async {
    showLoading();
    ChatModel receive = await _chatService.chat(ChatParameter(generateContent.value));
    generateContentResult.add(receive.message);
    generateContentResult.refresh();
    disableLoading();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}