import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

class ApiClient {
  //싱글톤으로 인스턴스 생성
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;

  // final FlutterSecureStorage _storage = FlutterSecureStorage();

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: FlutterConfig.get("base_url"),
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // 인터셉터 추가
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // final token = await _storage.read(key: 'auth_token');

        // 현재 token 발급 api가 없으므로 FlutterConfig에 저장한 임시 토큰을 끼웁니다.
        // 추후 FlutterSecureStorage로 이관합니다.
        var token = FlutterConfig.get("mento_token");
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
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

    // LogInterceptor 추가
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
