import 'package:ai_ecard/models/account/account_model.dart';
import 'package:ai_ecard/models/models/token/token.dart';
import 'package:ai_ecard/models/parameters/base_params.dart';
import 'package:ai_ecard/models/response/base_response.dart';
import 'package:ai_ecard/service/api_service.dart';
import 'package:dio/dio.dart';

class UserService extends ApiService {
  Future<TokenObj> getToken(BaseParameter params) async {
    Response response = await post(path: '/api/account/token', params: params.build());
    BaseResponse<TokenObj> token = convertResponse<TokenObj>(
        response: response, dataHandler: (json) => TokenObj.fromJson({'access_token': json, 'refresh_token': null}));
    return token.data;
  }
}
