import 'dart:developer';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/refresh_token_response.dart';
import 'package:cogo/data/dto/response/token_response.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:dio/dio.dart';

class RefreshService {
  final ApiClient _apiClient = ApiClient();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  /// POST google 서버에서 받은 accessToken으로 서비스 accessToken 발급
  Future<TokenResponse> getAccessToken(String authCode, String name) async {
    try {
      final response = await _apiClient.dio.post(
        options: Options(
          extra: {'skipAuthToken': true}, //토큰 해제
        ),
        Apis.getAccessToken,
        queryParameters: {
          'accessToken': authCode,
          'name': name,
        },
      );
      if (response.statusCode == 200) {
        // BaseResponse
        final baseResponse = BaseResponse<TokenResponse>.fromJson(
          response.data as Map<String, dynamic>,
          (contentJson) =>
              TokenResponse.fromJson(contentJson as Map<String, dynamic>),
        );

// AccessToken 저장 로직 수정
        final tokenResponse = baseResponse.content;

        if (tokenResponse != null) {
          await _secureStorage.saveAccessToken(tokenResponse.accessToken);
          await _secureStorage.saveRefreshToken(tokenResponse.refreshToken);

          log("accessToken ${tokenResponse.accessToken} refreshtoken ${tokenResponse.refreshToken}");
        }

        return tokenResponse;
      } else {
        throw Exception(
            'Failed to send verification code ${response.data.toString()}');
      }
    } on DioException catch (e) {
      //애로 감 다
      throw Exception('Error: ${e.response?.data.toString() ?? e.message}');
    }
  }

  /// POST refreshToken으로 서비스 accessToken, refreshToken 재발급
  Future<RefreshTokenResponse> reissueToken() async {
    try {
      var refreshToken = await _secureStorage.readRefreshToken();

      final response = await _apiClient.dio.post(
        options: Options(
          extra: {'skipAuthToken': true},

          ///기존 엑세스 토큰을 해제함
          headers: {
            'refreshToken': 'Bearer $refreshToken',
          },
        ),
        Apis.reissueToken,
        queryParameters: {},
      );
      if (response.statusCode == 200) {
        // BaseResponse
        final baseResponse = BaseResponse<RefreshTokenResponse>.fromJson(
          response.data as Map<String, dynamic>,
          (contentJson) => RefreshTokenResponse.fromJson(
              contentJson as Map<String, dynamic>),
        );

// AccessToken 저장 로직 수정
        final tokenResponse = baseResponse.content;

        if (tokenResponse != null) {
          await _secureStorage.saveAccessToken(tokenResponse.accessToken);
          await _secureStorage.saveRefreshToken(tokenResponse.refreshToken);
        }

        return tokenResponse;
      } else {
        throw Exception(
            'Failed to send verification code ${response.data.toString()}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data.toString() ?? e.message}');
    }
  }
}
