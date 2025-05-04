import 'dart:developer';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/email_verification_response.dart';
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

  ///POST /api/v2/users 사용자 정보 수정
  Future<UserInfoResponse> patchUserInfo(
      String phoneNum, String name, String? email) async {
    try {
      final response = await _apiClient.dio.patch(
        options: Options(
          extra: {'skipAuthToken': false},
        ),
        apiVersion + Apis.user,
        data: {
          'name': name,
          'email': email,
          'phoneNum': phoneNum,
        },
      );
      if (response.statusCode == 200) {
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
          extra: {'skipAuthToken': false},
        ),
        apiVersion + Apis.user,
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
      if (response.statusCode == 201) {
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
          extra: {'skipAuthToken': false}, //토큰 해제를 하지 마라
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

  ///POST /auth/email 이메일 인증 코드
  Future<EmailVerificationResponse> emailVerificationCode(String email) async {
    try {
      final response = await _apiClient.dio.get(
        options: Options(
          extra: {'skipAuthToken': false}, //토큰 해제
        ),
        Apis.sendEmail,
        queryParameters: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<EmailVerificationResponse>.fromJson(
          response.data,
          (contentJson) => EmailVerificationResponse.fromJson(contentJson),
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

  ///DELETE /api/v2/user 탈퇴하기
  Future<void> signOut() async {
    try {
      final response = await _apiClient.dio.delete(
        apiVersion + Apis.user,
        options: Options(extra: {'skipAuthToken': false} //토큰 해제를 하지 마라
            ),
      );
      if (response.statusCode == 200) {
        log("탈퇴 성공");
      } else {
        throw Exception('Failed to send verification code ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  ///PUT /api/v2/users/picture 이미지 저장하기
  Future<bool> saveImage(String imageUrl) async {
    try {
      final response =
          await _apiClient.dio.put(apiVersion + Apis.saveImage, data: imageUrl);

      //todo 여기 response가 존재하나 필요가 없어서 안받음
      // {
      //   "statusCode": "201",
      //   "message": "CREATED",
      //   "content": {
      //   "username": "113343694546635833713",
      //   "name": "222",
      //   "email": "objet917@gmail.com",
      //   "role": "ROLE_MENTOR",
      //   "phoneNum": "123-1231-2312",
      //   "picture": "\"https://cogo-bucket.s3.ap-northeast-2.amazonaws.com/v2/113343694546635833713\""
      // }
      // }
      if (response.statusCode != 201) {
        throw Exception('Failed to send verification code ${response.data}');
      }
      return true;
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
