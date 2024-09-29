import 'dart:developer';

import 'package:cogo/data/model/base_response.dart';
import 'package:dio/dio.dart';

import '../../constants/apis.dart';
import '../di/api_client.dart';
import '../model/sms_verification_result.dart';

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
        log("Server response: ${response.data}"); //이거 됨
        // response.data를 SmsVerificationResult 객체로 변환

        // Wrapping the response into BaseResponse
        final baseResponse = BaseResponse<SmsVerificationResult>.fromJson(
          response.data,
          (contentJson) => SmsVerificationResult.fromJson(contentJson),
        );

        log("content: ${baseResponse.content}"); //이거 안나옴
        // Return the unwrapped content to the ViewModel
        return baseResponse.content;
      } else {
        throw Exception('Failed to send verification code');
      }
    } on DioException catch (e) {
      log("DioError: ${e.response?.data ?? e.message}");
      throw Exception('Error: ${e.response?.data ?? e.message}');
    }
  }
}
