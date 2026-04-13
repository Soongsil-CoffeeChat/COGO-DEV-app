import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  factory ApiClient() => _instance;

  ApiClient._internal() {
    final baseUrl = kIsWeb
        ? 'https://back-coffeego.com/' // 🌐 웹 전용 기본 URL 설정
        : dotenv.get('base_url', fallback: 'https://back-coffeego.com/');

    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
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
        try {
          final skip = options.extra['skipAuthToken'] == true;
          final token = skip ? null : await _secureStorage.readAccessToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            debugPrint('[Interceptor] Authorization header 설정됨 (token: $token)');
          } else {
            debugPrint('[Interceptor] 토큰 없음 (skip=$skip), path=${options.path}');
          }

          return handler.next(options);
        } catch (e) {
          debugPrint('[Interceptor] onRequest 예외: $e');
          return handler.next(options);
        }
      },
      onResponse: (response, handler) {
        debugPrint('[Interceptor] 응답 ${response.statusCode} — ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        final requestOptions = e.requestOptions;
        debugPrint('[Interceptor] 에러 발생 — path=${requestOptions.path}, status=${e.response?.statusCode}');

        // skipAuthToken이 true라면, 토큰 재발급 로직을 타지 않도록 차단
        if (requestOptions.extra['skipAuthToken'] == true) {
          debugPrint('[Interceptor] skipAuthToken=true 요청은 재발급 시도 안 함');
          return handler.next(e);
        }

        if (requestOptions.extra['retry'] == true ||
            requestOptions.path.contains('reissue')) {
          debugPrint('[Interceptor] 이미 토큰 재시도를 했거나 재발급 요청 자체가 실패했습니다. 재시도 중단.');
          return handler.reject(e);
        }

        if (e.response?.statusCode == 401) {
          try {
            debugPrint('[Interceptor] 401 → 토큰 재발급 시도 중... (path=${requestOptions.path})');

            final authService = GetIt.instance<AuthService>();
            await authService.reissueToken();

            final newToken = await _secureStorage.readAccessToken();
            if (newToken == null) throw Exception('재발급된 토큰이 없습니다.');

            debugPrint('[Interceptor] 토큰 재발급 성공 → 요청 재시도');
            final clonedRequest = await _dio.request(
              requestOptions.path,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                responseType: requestOptions.responseType,
                headers: {
                  ...requestOptions.headers,
                  'Authorization': 'Bearer $newToken',
                },
                extra: {
                  ...requestOptions.extra,
                  'retry': true,
                  'skipAuthToken': true,
                },
              ),
            );

            return handler.resolve(clonedRequest);
          } catch (refreshError) {
            debugPrint('[Interceptor] 토큰 재발급 실패: $refreshError');
            return handler.reject(e);
          }
        }

        return handler.next(e);
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
