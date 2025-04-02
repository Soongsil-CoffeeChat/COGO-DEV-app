import 'dart:developer';

import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/request/time_select_request.dart';
import 'package:cogo/data/dto/response/add_possible_date_response.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:dio/dio.dart';

class PossibledateService {
  /// 커피챗 시간 관련 api

  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  ///  Put 멘토가 직접 커피챗 가능시간 갱신하기
  Future<AddPossibleDateResponse> updateMentorPossibleDates(
      List<TimeSlotDto> availableTimes) async {
    try {
      final response = await _apiClient.dio.put(
        '$apiVersion${Apis.possibleDates}',
        data: availableTimes, // time slot 리스트
        options: Options(
          extra: {'skipAuthToken': false},
        ),
      );

      //base response로 받는건 여기서 뿐임.
      final baseResponse = BaseResponse<AddPossibleDateResponse>.fromJson(
        response.data,
        (contentJson) => AddPossibleDateResponse.fromJson(contentJson),
      );

      if (response.statusCode == 200) {
        ///추가라서 201임
        log('Mentor possible dates updated successfully');
        log(baseResponse.content.toString());

        return baseResponse.content;
      } else {
        log(baseResponse.statusCode + baseResponse.message);
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

  /// GET 커피쳇 가능 시간 불러오기 (토큰 사용으로 불러오기) api
  Future<List<Map<String, dynamic>>> getMentorPossibleDatesWithToken() async {
    try {
      final response = await _apiClient.dio.get(
        '$apiVersion${Apis.possibleDates}',
        options: Options(
          extra: {'skipAuthToken': false},
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
