import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  //싱글톤으로 인스턴스 생성
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

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

        const token =
            "eyJhbGciOiJIUzI1NiJ9.eyJjYXRlZ29yeSI6ImFjY2VzcyIsInVzZXJuYW1lIjoiZ29vZ2xlIDExNDk2MjE2MTU2OTAwNTk0NzY2OCIsInJvbGUiOiJST0xFX01FTlRPUiIsImlhdCI6MTcyNTg3MjY1OCwiZXhwIjoxNzI3NjcyNjU4fQ.2IO784c9CD3lpxpii9U2iFpbD-zaum-dupFeeEU2RAg";
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        print('요청 보내는 중: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 응답 처리
        print('Received response: ${response.statusCode}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // 에러 처리
        print('Error: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;

  // GET 요청 메서드
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  // POST 요청 메서드
  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

// 다른 HTTP 메서드들도 필요에 따라 추가할 수 있습니다.

// 회원가입 메서드
  Future<bool> signUp(String email, String password) async {
    try {
      final response = await _dio.post('/auth/signup', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 토큰 저장
        final token = response.data['token'];
        await _storage.write(key: 'auth_token', value: token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Sign up error: $e');
      return false;
    }
  }

  // 토큰 가져오기
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // 토큰 삭제 (로그아웃 시 사용)
  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
