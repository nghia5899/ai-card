import 'package:ai_ecard/models/parameters/base_params.dart';
import 'package:ai_ecard/service/app_storage.dart';

class ChatParameter extends BaseParameter {
  String text;

  ChatParameter(this.text);

  @override
  Map<String, dynamic> build() {
    params['text'] = text;
    params['token'] = AppStorage.accessToken;
    return super.build();
  }
}
