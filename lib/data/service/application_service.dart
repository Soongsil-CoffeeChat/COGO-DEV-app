import 'dart:developer';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/request/cogo_decision_request.dart';
import 'package:cogo/data/dto/response/cogo_application_response.dart';
import 'package:cogo/data/dto/response/requested_cogo_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

class ApplicationService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  // TODO 실제 토큰으로 코드 변환 필요
  String token = FlutterConfig.get('mentee_token');

  // Cogo 신청
  Future<CogoApplicationResponse> postCogo(
      int mentorId, int possibleDateId, String memo) async {
    try {
      final response = await _apiClient.dio.post(
        apiVersion + Apis.application,
        data: {
          'mentorId': mentorId,
          'possibleDateId': possibleDateId,
          'memo': memo,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());

        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData['content'] != null) {
          final contentJson = responseData['content'] as Map<String, dynamic>;
          return CogoApplicationResponse.fromJson(contentJson);
        } else {
          throw Exception('Unexpected response format: $responseData');
        }
      } else if (response.statusCode == 404) {
        // TODO 가능한 시간이 없을때 처리 로직
        throw Exception('Resource not found (404). Please check the request.');
      } else if (response.statusCode == 410) {
        // TODO 선점된 시간 처리 로직
        throw Exception('Resource is no longer available (410).');
      } else {
        throw Exception(
            'Failed to post Cogo application: ${response.statusCode} ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// 멘토 토큰 설정
  String mentorToken = FlutterConfig.get('mentor_token');

  // 신청받은/신청한 COGO 조회
  Future<List<RequestedCogoResponse>> getRequestedCogo(String status) async {
    try {
      final response = await _apiClient.dio.get(
        '$apiVersion${Apis.application}/status?status=$status',
        options: Options(
          extra: {'skipAuthToken': false},
          headers: {
            'Authorization': 'Bearer $mentorToken',
          },
        ),
      );

      log('API Response: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('content') &&
            responseData['content'] is List) {
          final contentList = responseData['content'] as List<dynamic>;
          return contentList
              .map((json) => RequestedCogoResponse.fromJson(json))
              .toList();
        } else if (responseData == null || responseData.isEmpty) {
          throw Exception('Empty or null response from server');
        } else {
          throw Exception('Unexpected response format: $responseData');
        }
      } else {
        throw Exception('Failed to fetch mentor details: ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // 특정 COGO 조회
  Future<RequestedCogoResponse> getCogoDetail(int applicationId) async {
    try {
      final response = await _apiClient.dio.get(
        '$apiVersion${Apis.application}/$applicationId',
        options: Options(
          extra: {'skipAuthToken': false},
          headers: {
            'Authorization': 'Bearer $mentorToken',
          },
        ),
      );

      log('API Response: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('content') &&
            responseData['content'] is Map<String, dynamic>) {
          final content = responseData['content'] as Map<String, dynamic>;
          return RequestedCogoResponse.fromJson(content);
        } else {
          throw Exception('Unexpected response format: $responseData');
        }
      } else {
        throw Exception('Failed to fetch COGO details: ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // 코고 수락/거절 api
  Future<CogoDecisionRequest> patchCogoDecision(
      int applicationId, String decision) async {
    try {
      final response = await _apiClient.dio.patch(
        '$apiVersion${Apis.application}/$applicationId/decision?decision=$decision',
        data: {
          'applicationId': applicationId,
          'decision': decision,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $mentorToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        log(response.data.toString());

        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('content') &&
            responseData['content'] is Map<String, dynamic>) {
          final content = responseData['content'] as Map<String, dynamic>;
          return CogoDecisionRequest.fromJson(content);
        } else {
          throw Exception('Unexpected response format: $responseData');
        }
      } else {
        throw Exception('Failed to fetch COGO details: ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
