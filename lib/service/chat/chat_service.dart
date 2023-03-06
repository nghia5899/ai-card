import 'dart:developer';

import 'package:ai_ecard/models/models/chat/chat_model.dart';
import 'package:ai_ecard/models/parameters/chat_params.dart';
import 'package:ai_ecard/models/response/base_response.dart';
import 'package:ai_ecard/service/api_service.dart';
import 'package:dio/dio.dart';

class ChatService extends ApiService {
  Future<ChatModel> chat(ChatParameter parameter) async {
    Response response = await post(path: '/api/account/chat', params: parameter.build());
    BaseResponse<ChatModel> baseResponse =
        convertResponse(response: response, dataHandler: (json) => ChatModel.fromJson(json));
    return baseResponse.data;
  }
}
