import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/sms_verification_response.dart';
import 'package:dio/dio.dart';

class UserService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  // GET /api/v2/users/sms - SMS 인증 요청
  Future<SmsVerificationResponse> sendVerificationCode(
      String phoneNumber) async {
    try {
      final response = await _apiClient.dio.get(
        apiVersion + Apis.sendSms,
        queryParameters: {
          'phoneNum': phoneNumber,
        },
      );
      if (response.statusCode == 200) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<SmsVerificationResponse>.fromJson(
          response.data,
          (contentJson) => SmsVerificationResponse.fromJson(contentJson),
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
