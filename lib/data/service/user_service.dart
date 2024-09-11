// user_service.dart
import 'package:dio/dio.dart';

import '../api_client.dart';

class UserService {
  final ApiClient _apiClient;

  UserService(this._apiClient);

  // GET /api/v2/users/sms - SMS 인증 요청
  Future<Map<String, dynamic>> requestSmsVerification(String phoneNum) async {
    try {
      // 전화번호를 query parameter로 전달
      final response = await _apiClient.dio.get(
        '/api/v2/users/sms',
        queryParameters: {
          'phoneNum': phoneNum,
        },
      );

      if (response.statusCode == 200) {
        // 요청 성공 시, 응답 데이터 반환
        return response.data;
      } else {
        throw Exception('SMS 인증 요청 실패');
      }
    } on DioError catch (e) {
      print(e);
      // 오류 발생 시 오류 메시지를 반환
      return {'error': '오류 발생: ${e.response?.data ?? e.message}'};
    }
  }
}
