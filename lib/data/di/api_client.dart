import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
            log('[Interceptor] Authorization header 설정됨');
          } else {
            log('[Interceptor] 토큰 없음');
          }

          return handler.next(options);
        } catch (e) {
          log('[Interceptor] onRequest 예외: $e');
          return handler.next(options);
        }
      },
      onResponse: (response, handler) {
        log('응답은요 : ${response.statusCode}');
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        final requestOptions = e.requestOptions;

        // 이미 재시도를 했거나, refresh 요청이라면 재시도 하지 않음
        if (requestOptions.extra['retry'] == true ||
            requestOptions.path.contains('reissue')) {
          log('[Interceptor] 이미 토큰 재시도를 했거나 재발급 요청 자체가 실패했습니다. 재시도 중단.');
          return handler.reject(e);
        }

        if (e.response?.statusCode == 401) {
          try {
            log('[Interceptor] 401 → 토큰 재발급 시도 중...');

            final authService = GetIt.instance<AuthService>();
            await authService.reissueToken();

            final newToken = await _secureStorage.readAccessToken();
            if (newToken == null) throw Exception('재발급된 토큰이 없습니다.');

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

            return handler.resolve(clonedRequest);
          } catch (refreshError) {
            log('[Interceptor] 토큰 재발급 실패: $refreshError');
            return handler.reject(e); // 재발급 실패 시 기존 에러 반환
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
