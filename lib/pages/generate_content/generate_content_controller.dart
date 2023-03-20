import 'dart:math';

import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/account/account_model.dart';
import 'package:ai_ecard/models/models/chat/chat_model.dart';
import 'package:ai_ecard/models/models/token/token.dart';
import 'package:ai_ecard/models/parameters/chat_params.dart';
import 'package:ai_ecard/service/app_storage.dart';
import 'package:ai_ecard/service/chat/chat_service.dart';
import 'package:ai_ecard/service/user/user_service.dart';
import 'package:bot_toast/bot_toast.dart';


class GenerateContentController extends GetxController{
  Rx<String> generateContent = ''.obs;
  late TextEditingController textController;
  RxList<String> generateContentResult = <String>[].obs;
  final ChatService _chatService;

  GenerateContentController(this._chatService);

  RxList<String> keywordSuggest = <String>[].obs;
  Rx<int> selectedIndex = (-1).obs;

  @override
  void onInit() async {
    super.onInit();
    textController = TextEditingController();
    keywordSuggest.value = greetings.sublist(0, min(10, greetings.length));
    try {
      showLoading();
      TokenObj token = await UserService().getToken(AccountModel('test', '123456'));
      if (token.accessToken != null) {
        AppStorage.accessToken = token.accessToken;
      }
      disableLoading();
    } catch(e){
      disableLoading();
    }
  }

  void updateContent(String? value){
    if((value?.trimLeft().trimRight().split('').length ?? 0) <= 8) {
      generateContent.value = value ?? '';
      keywordSuggest.value = greetings.where((e) => e.toLowerCase().contains(generateContent.value.toLowerCase())).toList();
    } else {
      textController.text = generateContent.value;
    }
  }

  void clearText() {
    textController.text = '';
    updateContent('');
  }

  void getPrompt() async {
    try {
      showLoading();
      ChatModel receive = await _chatService.chat(ChatParameter(keywordSuggest.value[selectedIndex.value]));
      generateContentResult.add(receive.message.replaceAll('\\n', '\n'));
      generateContentResult.refresh();
      disableLoading();
    } catch(e){
      disableLoading();
      showMessage('Generate text failed', type: 'FAIL');
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
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

  Rx<int> get words => generateContent.value.isNotEmpty ? generateContent.value.trimLeft().trimRight().split(' ').length.obs : 0.obs;
}