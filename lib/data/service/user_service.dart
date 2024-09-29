import 'package:dio/dio.dart';

import '../di/api_client.dart';
import '../model/sms_verification_result.dart';

class UserService {
  final ApiClient _apiClient = ApiClient();

  // GET /api/v2/users/sms - SMS 인증 요청
  Future<SmsVerificationResult> sendVerificationCode(String phoneNumber) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/v2/users/sms', //Todo 이것도 한번에 관리?
        queryParameters: {
          'phoneNum': phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to send verification code');
      }
    } on DioError catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    }
  }
}
