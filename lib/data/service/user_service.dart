import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/mentee_signup_response.dart';
import 'package:cogo/data/dto/response/mentor_signup_response.dart';
import 'package:cogo/data/dto/response/my_info_response.dart';
import 'package:cogo/data/dto/response/sms_verification_response.dart';
import 'package:cogo/data/dto/response/user_info_response.dart';
import 'package:dio/dio.dart';

class UserService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  /// GET /api/v2/users/sms - SMS 인증 요청
  Future<SmsVerificationResponse> sendVerificationCode(
      String phoneNumber) async {
    try {
      final response = await _apiClient.dio.get(
        options: Options(
          extra: {'skipAuthToken': false}, //토큰 해제하지 않음
        ),
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
    } catch (e) {
      // 기타 모든 예외 처리
      throw Exception('An unexpected error occurred: $e');
    }
  }

  ///POST /api/v2/users 기본정보 기입
  Future<UserInfoResponse> setUserInfo(String phoneNumber, String name) async {
    try {
      final response = await _apiClient.dio.post(
        options: Options(
          extra: {'skipAuthToken': false},
        ),
        apiVersion + Apis.userInfo,
        data: {
          'phoneNum': phoneNumber,
          'name': name,
        },
      );
      if (response.statusCode == 201) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<UserInfoResponse>.fromJson(
          response.data,
          (contentJson) => UserInfoResponse.fromJson(contentJson),
        );
        return baseResponse.content;
      } else {
        throw Exception('Failed to send verification code ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  ///GET /api/v2/users 기본정보 조회
  Future<MyInfoResponse> getUserInfo() async {
    try {
      final response = await _apiClient.dio.get(
        options: Options(
          extra: {'skipAuthToken': true},
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJjYXRlZ29yeSI6ImFjY2VzcyIsInVzZXJuYW1lIjoiZ29vZ2xlIDEwMzM2NDQ3MTQ1MTk0NDk0MDYxNSIsInJvbGUiOiJST0xFX01FTlRPUiIsImlhdCI6MTczMDg4MDY5OSwiZXhwIjoxNzMyNjgwNjk5fQ.FoyJo5kjsp4xm7ulZBzBNl2L_pOO79jwI7QPwjgXKjw',
          },
        ),
        apiVersion + Apis.userInfo,
      );
      if (response.statusCode == 200) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<MyInfoResponse>.fromJson(
          response.data,
          (contentJson) => MyInfoResponse.fromJson(contentJson),
        );
        return baseResponse.content;
      } else {
        throw Exception('Failed to send verification code ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  ///POST /api/v2/users/mentor  멘토로 가입하기!
  Future<MentorSignupResponse> signUpMentor(String part, String club) async {
    try {
      final response = await _apiClient.dio.post(
        options: Options(
          extra: {'skipAuthToken': false}, //토큰 해제
        ),
        apiVersion + Apis.signUpMentor,
        data: {
          'part': part,
          'club': club,
        },
      );
      if (response.statusCode == 200) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<MentorSignupResponse>.fromJson(
          response.data,
          (contentJson) => MentorSignupResponse.fromJson(contentJson),
        );
        return baseResponse.content;
      } else {
        throw Exception('Failed to send verification code ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  ///POST /api/v2/users/mentee  멘티로 가입하기!
  Future<MenteeSignupResponse> signUpMentee(String part) async {
    try {
      final response = await _apiClient.dio.post(
        options: Options(
          extra: {'skipAuthToken': false}, //토큰 해제
        ),
        apiVersion + Apis.signUpMentee,
        data: {
          'part': part,
        },
      );
      if (response.statusCode == 201) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<MenteeSignupResponse>.fromJson(
          response.data,
          (contentJson) => MenteeSignupResponse.fromJson(contentJson),
        );
        return baseResponse.content;
      } else {
        throw Exception('Failed to send verification code ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
