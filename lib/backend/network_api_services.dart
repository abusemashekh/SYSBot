import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sysbot3/backend/api_end_points.dart';
import 'package:sysbot3/backend/status_code_response.dart';
import 'package:sysbot3/utils/functions/common_fun.dart';

///Base Api Services abstract class for calling all the types of apis
abstract class BaseApiServices {
  Future<dynamic> getApi(String url);

  Future<dynamic> postApi(dynamic data, String url);
}

class NetworkApiServices extends BaseApiServices {
  // final LocalStorage _localStorage = LocalStorage();
  final Dio _dio = _createDio();

  NetworkApiServices._internal();

  static final NetworkApiServices _singleton = NetworkApiServices._internal();

  factory NetworkApiServices() => _singleton;

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.serverUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 90),
      ),
    );
    dio.interceptors.add(ErrorInterceptor(dio));
    return dio;
  }

  @override
  Future<dynamic> getApi(String url) async {
    debugPrint('Url: ${_dio.options.baseUrl + url}');

    // final token = _localStorage.getToken;
    // final headers = token.isNotEmpty ? {'Authorization': 'Bearer $token'} : null;

    final response = await _dio.get(
      _dio.options.baseUrl + url,
      // options: Options(headers: headers),
    );
    debugPrint('JsonResponse: ${response.data}');
    return response.data;
  }

  @override
  Future<dynamic> postApi(dynamic data, String url) async {
    logPrint(message: 'Url: ${_dio.options.baseUrl + url}');
    logPrint(message: 'Data: $data');

    // final token = _localStorage.getToken;
    // final headers = token.isNotEmpty ? {'Authorization': 'Bearer $token'} : null;

    final response = await _dio.post(
      _dio.options.baseUrl + url,
      // options: Options(headers: headers),
      data: data,
    );
    logPrint(message: 'JsonResponse: ${response.data}');
    return response.data;
  }
}
