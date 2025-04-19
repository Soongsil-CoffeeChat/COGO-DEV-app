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
  final AuthService authService = GetIt.instance<AuthService>();

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

    /// Token Interceptor 추가
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.extra['skipAuthToken'] != true) {
          final token = await _secureStorage.readAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        return handler.next(options);
      },
      onResponse: (response, handler) => handler.next(response),
      onError: (DioException e, handler) async {
        // JWT_003 체크
        final errorCode = e.response?.data['error'];
        final requestOptions = e.requestOptions;

        if (errorCode == 'JWT_003') {
          try {
            log('[Interceptor] JWT_003 → 토큰 재발급 시도 중...');
            await authService.reissueToken(); // 토큰 재발급

            // 새로운 access token 가져오기
            final newToken = await _secureStorage.readAccessToken();

            // 이전 요청 복사 후 헤더만 수정
            final newOptions = Options(
              method: requestOptions.method,
              headers: {
                ...requestOptions.headers,
                'Authorization': 'Bearer $newToken',
              },
            );

            // 원래 요청 재시도
            final clonedRequest = await _dio.request(
              requestOptions.path,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
              options: newOptions,
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
  }
  Dio get dio => _dio;
}
