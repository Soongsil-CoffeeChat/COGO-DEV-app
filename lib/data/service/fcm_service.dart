import 'dart:developer';
import 'dart:io';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:dio/dio.dart';

class FcmService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  /// POST /api/v2/push/tokens - FCM 토큰 서버에 등록
  Future<void> registerFcmToken(String fcmToken) async {
    try {
      final response = await _apiClient.dio.post(
        apiVersion + Apis.pushToken,
        data: {
          'token': fcmToken,
          'platform': Platform.isIOS ? 'IOS' : 'ANDROID',
        },
        options: Options(
          extra: {'skipAuthToken': false},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('[FCM] 토큰 서버 등록 성공');
      } else {
        throw Exception('FCM 토큰 등록 실패: ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
