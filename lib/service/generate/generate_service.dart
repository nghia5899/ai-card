import 'package:ai_ecard/global.dart';
import 'package:ai_ecard/models/parameters/generate_params.dart';
import 'package:ai_ecard/service/api_service.dart';
import 'package:dio/dio.dart';

class GenerateService extends ApiService {

  final apiService = ApiService(url: 'https://api.photosonic.ai',accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIxYTQ0MDA4LTM4NDktNGM3YS04NmIyLTQxYmMxYTJlMTI4NyIsImV4cCI6MTY3OTk3NDI3MH0.fB1JreOk7V1VE5hjR8Kpt6P_YlWmRV8Ddq6ahWzy-Kg');

   passer(GenerateParameter parameter) async {
    Response response = await apiService.post(path: '/v1/photosonic/generate-image', params: parameter.build());
    return response.data;
    // BaseResponse<Generate> baseResponse =
    // convertResponse(response: response, dataHandler: (json) => Generate.fromJson(json));
    // return baseResponse.data;
  }
}
