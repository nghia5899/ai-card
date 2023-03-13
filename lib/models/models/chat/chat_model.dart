class ChatModel {
  String? _message;

  ChatModel(this._message);

  ChatModel.fromJson(dynamic json) {
    _message = json;
  }

  String get message => _message ?? '';
}
