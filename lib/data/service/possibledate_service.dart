import 'dart:developer';

import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/request/time_select_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

class PossibledateService {
  /// 커피챗 시간 관련 api

  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  //TODO : 추후 실제 유저 토큰으로 바꿔야 함
  String token = FlutterConfig.get('mentor_token');

  ///  POST
  ///  멘토가 직접 커피챗 가능시간 갱신하기
  Future<void> updateMentorPossibleDates(
      List<TimeSlotDto> availableTimes) async {
    try {
      final response = await _apiClient.dio.post(
        '$apiVersion${Apis.possibleDates}',
        data: availableTimes, // 요청 본문 데이터
        options: Options(
          extra: {'skipAuthToken': false},
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // 성공적으로 갱신됨
        log('Mentor possible dates updated successfully');
      } else {
        throw Exception(
            'Failed to update mentor possible dates: ${response.statusCode}');
      }
    } on DioError catch (e) {
      log('Dio Error: ${e.response?.data ?? e.message}');
      throw Exception('Dio Error: ${e.response?.data ?? e.message}');
    }
  }

  /// GET 커피쳇 가능 시간 불러오기 api
  Future<List<Map<String, dynamic>>> getMentorPossibleDates(
      int mentorId) async {
    try {
      final response = await _apiClient.dio.get(
        '$apiVersion${Apis.possibleDates}/$mentorId',
        options: Options(
          extra: {'skipAuthToken': false},
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['content'] is List) {
          return List<Map<String, dynamic>>.from(responseData['content']);
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to fetch mentor possible dates: ${response.statusCode}');
      }
    } on DioError catch (e) {
      log('Dio Error: ${e.response?.data ?? e.message}');
      throw Exception('Dio Error: ${e.response?.data ?? e.message}');
    }
  }
}
