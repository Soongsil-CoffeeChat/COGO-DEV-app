import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/model/base_response.dart';
import 'package:cogo/data/model/sms_verification_result.dart';
import 'package:dio/dio.dart';

class UserService {
  final ApiClient _apiClient = ApiClient();

  // GET /api/v2/users/sms - SMS 인증 요청
  Future<SmsVerificationResult> sendVerificationCode(String phoneNumber) async {
    try {
      final response = await _apiClient.dio.get(
        Apis.sendSms,
        queryParameters: {
          'phoneNum': phoneNumber,
        },
      );
      if (response.statusCode == 200) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<SmsVerificationResult>.fromJson(
          response.data,
          (contentJson) => SmsVerificationResult.fromJson(contentJson),
        );
        return baseResponse.content;
      } else {
        throw Exception('Failed to send verification code');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    }
  }
}
