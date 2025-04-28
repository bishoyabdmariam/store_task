import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParam,
  });

  Future<Response<dynamic>> post(
    String path, {
    Map<String, dynamic>? queryParam,
    Map<String, dynamic>? body,
  });
}
