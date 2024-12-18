import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal(); //싱글톤으로 인스턴스 생성
  late Dio _dio;
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: FlutterConfig.get("base_url"),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Token Interceptor 추가
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 특정 API에서만 토큰을 제외
        if (options.extra['skipAuthToken'] != true) {
          var token = await _secureStorage.readAccessToken();
          log("secureStroage " + token.toString());
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        log('요청 보내는 중: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 응답 처리
        log('응답은요 : ${response.statusCode}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // 에러 처리
        log('Error: ${e.message}');
        return handler.next(e);
      },
    ));

    // Log Interceptor 추가
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (obj) {
        log("서버통신 $obj");
      },
    ));
  }

  Dio get dio => _dio;
}
