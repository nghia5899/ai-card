import 'package:ai_ecard/global.dart';
import 'package:ai_ecard/models/parameters/generate_params.dart';
import 'package:ai_ecard/service/api_service.dart';
import 'package:dio/dio.dart';

class GenerateService extends ApiService {

  final apiService = ApiService(url: 'https://api.writesonic.com',accessToken: apiKey);

   passer(GenerateParameter parameter) async {
    Response response = await apiService.post(path: '/v1/photosonic/content/generate-image', params: parameter.build());
    return response.data;
    // BaseResponse<Generate> baseResponse =
    // convertResponse(response: response, dataHandler: (json) => Generate.fromJson(json));
    // return baseResponse.data;
  }
}
