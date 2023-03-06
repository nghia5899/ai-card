import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

/// Backend makes too much response types so we have to deal with each one of them
class BaseResponse<T> {
  BaseResponse({this.status, this.statusCode, this.message});

  BaseResponse.fromJson(dynamic json, {required T Function(dynamic data) dataHandler}) {
    catchAnyError(() {
      status = json['status'];
      statusCode = json['statusCode'];
      message = json['message'];
      // errorCode = json['errorCode'];
      // error = json['error'];
      data = dataHandler.call(json['data']);
    }, tag: 'BaseResponse.fromJson');
  }

  void fromJson(Map<String, dynamic> json) {
    catchAnyError(() {
      status = json['status'];
      statusCode = json['statusCode'];
      message = json['message'];
      error = json['error'];

    }, tag: 'BaseResponse fromJson');
  }

  dynamic status;
  int? statusCode;
  int? errorCode;
  String? message;
  String? error;
  late T data;

  bool get isSuccess => status == 'SUCCESS';

  bool get shouldForceLogOut => errorCode == HttpStatus.unauthorized;

  bool get hasData => data != null;

  /// take care of error messages
  String? get errorMessage {
    if (error == 'invalid_token' || error == 'unauthorized') {
      return null;
    }

    if (status == 500) {
      return error;
    }

    if (message != null) {
      return message;
    }

    return 'common_unknown_error'.tr;
  }
}

void catchAnyError<T>(Function() exceptionThrowableBlock, {String tag = 'ERROR'}) {
  try {
    exceptionThrowableBlock.call();
  } catch (e) {
    Logger().e(e.toString());
  }
}
