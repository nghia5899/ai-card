import 'dart:html';
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
  T? data;

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

void catchAnyError<T>(VoidCallback exceptionThrowableBlock, {String tag = 'ERROR'}) {
  try {
    exceptionThrowableBlock();
  } catch (e) {
    Logger().e(e.toString());
  }
}

// class BaseListResponse<E> extends BaseResponse {
//   List<E>? _data;
//   List<E> get data => _data ?? [];
//   late E Function(dynamic) elementHandler;
//
//   BaseListResponse();
//
//   @override
//   fromJson(dynamic json) {
//     super.fromJson(json);
//     if (json['data'] == null) {
//       _data = null;
//       return;
//     }
//
//     _data = [];
//
//     json['data'].forEach((e) {
//       _data?.add(elementHandler(e));
//     });
//   }
// }
//
// class EmptyResponse extends BaseResponse {}
//
// class ListResponse<T> extends BaseResponse {
//   List<T> items = [];
//   int? total = 0;
//   late T Function(dynamic) elementHandler;
//
//   @override
//   fromJson(dynamic json) {
//     super.fromJson(json);
//
//     catchAnyError(() {
//       if (json?['data'] == null) {
//         return;
//       }
//
//       final listData = json['data']['content'] as List<dynamic>;
//       items = listData.map((e) => elementHandler.call(e)).toList();
//       total = json['data']['totalElements'];
//     });
//   }
// }
