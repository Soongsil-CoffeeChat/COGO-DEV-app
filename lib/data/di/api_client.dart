import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_it/get_it.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  factory ApiClient() => _instance;

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
      onError: (DioException e, handler) async {
        // JWT_003 체크
        final errorCode = e.response?.data['error'];
        final requestOptions = e.requestOptions;

        if (e.response?.statusCode == 401) {
          try {
            log('[Interceptor] 401 → 토큰 재발급 시도 중...');

            final authService = GetIt.instance<AuthService>();
            await authService.reissueToken();

            // 새로운 access token 가져오기
            final newToken = await _secureStorage.readAccessToken();

            // 이전 요청 복사 후 헤더 수정 및 재시도 플래그 추가
            final clonedRequest = await _dio.request(
              requestOptions.path,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                headers: {
                  ...requestOptions.headers,
                  'Authorization': 'Bearer $newToken',
                },
                extra: {
                  ...requestOptions.extra,
                  'retry': true,
                },
              ),
            );

            return handler.resolve(clonedRequest); // 성공 응답으로 대체
          } catch (refreshError) {
            log('[Interceptor] 토큰 재발급 실패: $refreshError');
            return handler.reject(e); // 기존 에러 유지
          }
        }

        return handler.next(e); // 다른 에러는 그대로
      },
    ));

    /// Log Interceptor 추가
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
