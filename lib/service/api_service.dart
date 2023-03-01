import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ai_ecard/models/response/base_response.dart';
import 'package:ai_ecard/utils/httplogging_utils.dart';
import 'package:ai_ecard/utils/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as dio_response;
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart' as get_connect;
import 'package:logger/logger.dart';

import 'app_storage.dart';

abstract class BaseProvider extends GetConnect {
  final String url;
  String apiPrefix;
  //
  // var shouldAddBearerToken = true;
  // var shouldShowExpiredPopup = true;
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 15000),
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
    ),
  );

  BaseProvider({required this.url, this.apiPrefix = ''});

  @override
  void onInit() async {
    // timeout = const Duration(seconds: 15);
    // allowAutoSignedCert = true;
    // httpClient.baseUrl = '$url$apiPrefix/api';
    // if (kDebugMode) {
    //   print('baseurl $baseUrl');
    // }
    // httpClient.errorSafety = true;
    // dio.options.baseUrl = httpClient.baseUrl!;
    // httpClient.addRequestModifier<void>((request) async {
    //     String? accessToken = AppStorage.accessToken;
    //
    //     if (!accessToken.isNullOrEmpty() && shouldAddBearerToken) {
    //         request.headers['Authorization'] = 'Bearer $accessToken';
    //     }
    //
    //     HttpLoggingUtils.requestLog(request);
    //
    //     return request;
    // });
    //
    // // httpClient.addAuthenticator<void>((request) async {
    // //   TokenService service = Get.find();
    // //   await service.refreshToken();
    // //   return request;
    // // });
    //
    // String? accessToken = await AppStorage.accessToken;
    // if (!accessToken.isNullOrEmpty()) {
    //     dio.options.headers['Authorization'] = 'Bearer $accessToken';
    // }
    //
    // httpClient.addResponseModifier((request, response) {
    //     HttpLoggingUtils.responseLog(response);
    //     // FirebaseUtils().traceNetworkResponse(response);
    //     // _handleIncomingResponse(response);
    //     return response;
    // });

    dio.interceptors.addAll([
      // InterceptorsWrapper(
      //     // handle onRequest
      //     onRequest: (
      //         RequestOptions requestOptions,
      //         RequestInterceptorHandler handler,
      //         ) async {
      //         String uri = requestOptions.uri.toString();
      //         if (UtilService.checkNeedAuthentication(uri)) {
      //             TokenObj? tokenObj = await SecureStorageService.getTokenObj();
      //             if (tokenObj != null && tokenObj.accessToken != null && tokenObj.accessToken != '') {
      //                 requestOptions.headers[HttpHeaders.authorizationHeader] = 'Bearer ${tokenObj.accessToken!}';
      //                 http.interceptors.requestLock.unlock();
      //                 return handler.next(requestOptions);
      //             }
      //         }
      //         http.interceptors.requestLock.unlock();
      //         return handler.next(requestOptions);
      //     },
      //     // handle onResponse
      //     onResponse: (
      //         Response response,
      //         ResponseInterceptorHandler handler,
      //         ) async {
      //         // Do something with response data
      //         Constants.refreshIters = 0;
      //         bool isValidData = response != null &&
      //             response.data != null &&
      //             response.requestOptions.uri.toString().indexOf('s3-ap') == -1;
      //         if (isValidData) {
      //             if (response.data['status'] != null) {
      //                 response.data['status'] = response.data['status'] == Constants.successText;
      //             }
      //             ResponseData responseData = ResponseData.fromJson(response.data);
      //             response.data = responseData;
      //             return handler.next(response);
      //         }
      //         return handler.next(response); // continue
      //     },
      //     // handle onError
      //     onError: (
      //         DioError error,
      //         ErrorInterceptorHandler handler,
      //         ) async {
      //         switch (error.type) {
      //             case DioErrorType.cancel:
      //                 print('requestCancelled');
      //                 break;
      //             case DioErrorType.connectTimeout:
      //             // _navigationService.showNetwork(
      //             //   message: 'MSG_ERROR_CONNECTION_TIMEOUT',
      //             //   urlImage: 'assets/images/icon/ic_connection_timeout.svg',
      //             //   heightImage: 100,
      //             // );
      //                 print('requestTimeout');
      //                 break;
      //             case DioErrorType.receiveTimeout:
      //                 print('sendTimeout');
      //                 break;
      //             case DioErrorType.response:
      //                 print('response error');
      //                 print(error.response);
      //                 switch (error.response?.statusCode) {
      //                     case 400:
      //                         print('Dio onError 400');
      //                         // try {
      //                         //   var message = error.response?.data['data'];
      //                         //   if (message != null && message is String && message != '') {
      //                         //     _navigationService.showToast(message);
      //                         //   } else {
      //                         //     _navigationService.showToast('TEXT_HTTP_400');
      //                         //   }
      //                         // } catch (e) {
      //                         //   print(e);
      //                         //   _navigationService.showToast('TEXT_HTTP_400');
      //                         // }
      //                         break;
      //                     case 401:
      //                         print('Dio onError 401');
      //                         print(error.requestOptions.uri);
      //                         Response? _response = await _refreshToken(error.response!.requestOptions);
      //                         if (_response != null) return handler.resolve(_response);
      //                         break;
      //                     case 403:
      //                         print('Dio onError 403');
      //                         Response? _response = await _refreshToken(error.response!.requestOptions);
      //                         if (_response != null) return handler.resolve(_response);
      //                         break;
      //                     case 406:
      //                         print('Dio onError 406');
      //                         Response? _response = await _refreshToken(error.response!.requestOptions);
      //                         if (_response != null) return handler.resolve(_response);
      //                         break;
      //                     case 404:
      //                         print('Dio onError 404');
      //                         // _navigationService.showNetwork();
      //                         break;
      //                     default:
      //                         break;
      //                 }
      //                 break;
      //             case DioErrorType.sendTimeout:
      //                 break;
      //             case DioErrorType.other:
      //                 print('Dio onError DioErrorType.other');
      //                 break;
      //         }
      //         return handler.next(error);
      //     },
      // ),
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
  }

  @override
  Future<get_connect.Response<T>> post<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    _logBodyRequest(body);
    return super.post(url, body,
        contentType: contentType, headers: headers, query: query, decoder: decoder, uploadProgress: uploadProgress);
  }

  Future<dio_response.Response<T>> postUpload<T>(String path, {data}) {
    return dio.post(path, data: data);
  }

  @override
  Future<get_connect.Response<T>> get<T>(String url,
      {String? contentType, Map<String, String>? headers, Map<String, dynamic>? query, Decoder<T>? decoder}) async {
    _logBodyRequest(query);
    return super.get(url, query: query, contentType: contentType, headers: headers, decoder: decoder);
  }

  @override
  Future<get_connect.Response<T>> put<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) {
    _logBodyRequest(body);
    return super.put(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  @override
  Future<get_connect.Response<T>> patch<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) {
    _logBodyRequest(body);
    return super.patch(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  /// Convert default response data
  BaseResponse<T> convertResponse<T>(
      {required get_connect.Response response,
      required T Function(dynamic) dataHandler,
      Map<String, dynamic>? fakeObject}) {
    return BaseResponse.fromJson({
      'status': response.status,
      'statusCode': response.statusCode,
      'message': response.statusText,
      'data': response.body
    }, dataHandler: dataHandler);
  }

  void _logBodyRequest(dynamic body) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyPrint = '';

    if (body is get_connect.FormData) {
      prettyPrint = 'Body length: ${body.length}';
    } else {
      prettyPrint = encoder.convert(body);
    }

    Logger().d('''
    ----------start----------
    ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ RequestBody ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓\n\n
    $prettyPrint
    \n\n↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ RequestBody ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑''');
  }

  static bool isShow = true;
}
