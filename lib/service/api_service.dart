import 'dart:async';
import 'dart:io';
import 'package:ai_ecard/evn.dart';
import 'package:ai_ecard/models/response/base_response.dart';
import 'package:ai_ecard/service/app_storage.dart';
import 'package:ai_ecard/utils/httplogging_utils.dart';
import 'package:ai_ecard/utils/string_extension.dart';
import 'package:dio/dio.dart';


Dio dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(milliseconds: 15000),
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ),

)..interceptors.addAll([
  QueuedInterceptorsWrapper(
    onRequest: (requestOptions, handler) async {
      HttpLoggingUtils.requestLog(requestOptions);
      String? accessToken = AppStorage.accessToken;
      if (!accessToken.isNullOrEmpty()) {
        requestOptions.headers['Authorization'] = 'Bearer $accessToken';
      }
      return handler.next(requestOptions);
    },
    onResponse: (response, handler) async {
      HttpLoggingUtils.responseLog(response);
      bool isValidData = response.data != null;
      if (isValidData) {
        if (response.data['status'] != null) {
          // response.data['status'] = response.data['status'] == Constants.successText;
        }
        return handler.next(response);
      }
    },
    onError: (error, handler) async {
      switch (error.type) {
        case DioErrorType.cancel:
          print('requestCancelled');
          break;
        case DioErrorType.connectionTimeout:
        // _navigationService.showNetwork(
        //   message: 'MSG_ERROR_CONNECTION_TIMEOUT',
        //   urlImage: 'assets/images/icon/ic_connection_timeout.svg',
        //   heightImage: 100,
        // );
          print('requestTimeout');
          break;
        case DioErrorType.receiveTimeout:
          print('sendTimeout');
          break;
        case DioErrorType.badResponse:
          print('response error');
          print(error.response);
          switch (error.response?.statusCode) {
            case 400:
              print('Dio onError 400');
              // try {
              //   var message = error.response?.data['data'];
              //   if (message != null && message is String && message != '') {
              //     _navigationService.showToast(message);
              //   } else {
              //     _navigationService.showToast('TEXT_HTTP_400');
              //   }
              // } catch (e) {
              //   print(e);
              //   _navigationService.showToast('TEXT_HTTP_400');
              // }
              break;
          // case 401:
          //     print('Dio onError 401');
          //     print(error.requestOptions.uri);
          //     Response? _response = await _refreshToken(error.response!.requestOptions);
          //     if (_response != null) return handler.resolve(_response);
          //     break;
          // case 403:
          //     print('Dio onError 403');
          //     Response? _response = await _refreshToken(error.response!.requestOptions);
          //     if (_response != null) return handler.resolve(_response);
          //     break;
          // case 406:
          //     print('Dio onError 406');
          //     Response? _response = await _refreshToken(error.response!.requestOptions);
          //     if (_response != null) return handler.resolve(_response);
          //     break;
          // case 404:
          //     print('Dio onError 404');
          //     // _navigationService.showNetwork();
          //     break;
            default:
              break;
          }
          break;
        case DioErrorType.sendTimeout:
          break;
        case DioErrorType.unknown:
          print('Dio onError DioErrorType.other');
          break;
      }
      return handler.next(error);
    },
  )
]);

class ApiService {
  late final String url;


  ApiService({String? url}){
    this.url = url ?? AppEnvironment.baseUrl;
  }

  Future<Response> post({required String path,  Map<String, dynamic>? params}) async {
    return await dio.post(url + path, data: params);
  }

  Future<Response> get({required String url, Map<String, dynamic>? params}) async {
      return await dio.get(url + url, queryParameters: params);
  }

  BaseResponse<T> convertResponse<T>({required Response response, required T Function(dynamic) dataHandler}){
    return BaseResponse.fromJson(response.data, dataHandler: dataHandler);
  }


}
