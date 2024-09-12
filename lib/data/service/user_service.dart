// user_service.dart
import 'package:dio/dio.dart';

import '../api_client.dart';

class UserService {
  final ApiClient _apiClient = ApiClient();

  // GET /api/v2/users/sms - SMS 인증 요청
  Future<Map<String, dynamic>> sendVerificationCode(String phoneNumber) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/v2/users/sms',
        queryParameters: {
          'phoneNum': phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        // JSON 데이터 파싱
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to send verification code');
      }
    } on DioError catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    }
  }
}
