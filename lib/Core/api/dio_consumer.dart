import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../injection_container.dart' as di;
import 'api_consumer.dart';
import 'app_interceptor.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({
    required this.client,
  }) {
    (HttpClient client) {};

    client.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParam,
    Map<String, dynamic>? body,
    bool useToken = true,
  }) async {
    return await client.get(
      path,
      data: body,
      queryParameters: queryParam,
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {},
      ),
    );
  }

  @override
  Future<Response<dynamic>> post(
    String path, {
    Map<String, dynamic>? queryParam,
    bool formDataIsEnabled = true,
    Map<String, dynamic>? body,
    bool useToken = true,
  }) async {
    return await client.post(
      path,
      queryParameters: queryParam,
      options: Options(
        contentType: formDataIsEnabled
            ? Headers.formUrlEncodedContentType
            : Headers.jsonContentType,
        headers: {},
      ),
      data: body,
    );
  }
}
