import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/models/chat/chat_model.dart';
import 'package:ai_ecard/models/parameters/chat_params.dart';
import 'package:ai_ecard/service/chat/chat_service.dart';

class ChatController extends GetxController {
  ChatService _chatService;

  ChatController(this._chatService);

  RxList<ChatModel> chatModels = <ChatModel>[].obs;

  String text = '';

  void updateText(String value) {
    text = value;
  }

  void sendChat() async {
    ChatModel send = ChatModel(text, true);
    chatModels.add(send);
    chatModels.refresh();
    int index = chatModels.length;
    ChatModel receive = await _chatService.chat(ChatParameter(text));
    receive.updateMessageType(false);
    if (chatModels.value.length > index) {
      chatModels.value.removeAt(index);
    }
    chatModels.add(receive);
    chatModels.refresh();
  }
}
