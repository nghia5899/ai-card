class ChatModel {
  String? _message;
  bool? _isSendMessage;

  ChatModel(this._message, this._isSendMessage);

  ChatModel.fromJson(dynamic json) {
    _message = json;
  }

  void updateMessageType(bool isSendMessage) {
    this._isSendMessage = isSendMessage;
  }

  String get message => _message ?? message;

  bool get isSendMessage => _isSendMessage ?? true;
}
