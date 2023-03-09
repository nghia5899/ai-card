import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class HttpLoggingUtils {
  static late DateTime _startTime;
  static late DateTime _endTime;
  static Logger logger = Logger();

  static void requestLog(RequestOptions request) {
    _startTime = DateTime.now();

    var message = '';

    if (request.method == 'get') {
      message += '----------start----------';
    }

    if (request.uri.path.isNotEmpty) {
      message += '\nRequestUrl: ${request.uri.path}';
    } else {
      // String queryString = Uri(queryParameters: request.url.queryParameters).query;
      message += '\nRequestUrl: ${request.uri.path}';
    }

    message += '\nRequestMethod: ${request.method}';

    if (request.headers.isNotEmpty) {
      message += '\nRequestHeaders: ${request.headers}';
    }
    String? contentType = request.headers['content-type'];
    if (contentType != null) {
      message += '\nRequestContentType: $contentType';
    }
    logger.log(Level.debug, message);
  }

  static void responseLog(Response response) {
    _endTime = DateTime.now();

    final int duration = _endTime.difference(_startTime).inMilliseconds;

    String? contentType = response.requestOptions.baseUrl;
    if ((contentType.contains('application/json') || contentType.contains('multipart/form-data'))) {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyPrint = encoder.convert(response.data);

      logger.log(Level.debug, """
----------End: $duration miliseconds----------
Response status code: ${response.statusCode}
Response URL: ${response.requestOptions.path}
↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ ResponseData ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓'
$prettyPrint
↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ ResponseData ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑""");
    } else {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyPrint = encoder.convert(response.data);

      logger.log(Level.debug, """
----------End: $duration miliseconds----------
Response status code: ${response.statusCode}
Response URL: ${response.requestOptions.path}
↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ ResponseData ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓'
$prettyPrint
↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ ResponseData ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑""");
    }
  }

  static void logDuration() {
    final int duration = _endTime.difference(_startTime).inMilliseconds;
    logger.log(Level.debug, '----------End: $duration miliseconds----------');
  }
}
