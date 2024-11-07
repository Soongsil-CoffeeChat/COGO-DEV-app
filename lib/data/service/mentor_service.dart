import 'dart:developer';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/mentor_detail_response.dart';
import 'package:cogo/data/dto/response/mentor_introduction_response.dart';
import 'package:cogo/data/dto/response/mentor_part_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

class MentorService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  //TODO 실제 토큰으로 코드 변환 필요
  String token = FlutterConfig.get('mentor_token');

  Future<MentorDetailResponse> getMentorDetail(String mentorId) async {
    try {
      final response = await _apiClient.dio.get(
        '$apiVersion${Apis.mentor}/$mentorId', // mentorId를 경로의 일부로 포함
        options: Options(
          extra: {'skipAuthToken': false},
          headers: {
            'Authorization': 'Bearer $token', // 가져온 토큰을 Authorization 헤더로 설정
          },
        ),
      );
      if (response.statusCode == 200) {
        print(response.data); // 서버 응답을 출력하여 확인
        final baseResponse = BaseResponse<MentorDetailResponse>.fromJson(
          response.data,
          (contentJson) {
            return MentorDetailResponse.fromJson(contentJson);
          },
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

  // 파트별 멘토리스트 호출
  Future<List<MentorPartResponse>> getMentorPart(String part) async {
    try {
      final response = await _apiClient.dio.get(
        apiVersion + Apis.mentorPart,
        options: Options(
          extra: {'skipAuthToken': false},
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'part': part,
        },
      );

      if (response.statusCode == 200) {
        //print(response.data);

        final baseResponse = BaseResponse<List<MentorPartResponse>>.fromJson(
          response.data,
          (contentJson) {
            return (contentJson as List)
                .map((item) => MentorPartResponse.fromJson(item))
                .toList();
          },
        );

        print('baseResponse:${baseResponse.content}');
        return baseResponse.content;
      } else {
        return <MentorPartResponse>[];
      }
    } on DioException catch (e) {
      return <MentorPartResponse>[];
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  //멘토 자기소개 입력
  Future<MentorIntroductionResponse> patchMentorIntroduction(
      String introductionTitle,
      String introductionDescription,
      String introductionAnswer1,
      String introductionAnswer2) async {
    try {
      final response = await _apiClient.dio.patch(
        apiVersion + Apis.mentorIntroduction,
        data: {
          'introduction_title': introductionTitle,
          'introduction_description': introductionDescription,
          'introduction_answer1': introductionAnswer1,
          'introduction_answer2': introductionAnswer2,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        log(response.data.toString());

        final responseData = response.data;

        // 데이터가 Map 형식인지 확인하여 서버 응답 처리추가
        if (responseData is Map<String, dynamic> &&
            responseData['content'] != null) {
          final contentJson = responseData['content'] as Map<String, dynamic>;
          return MentorIntroductionResponse.fromJson(contentJson);
        } else {
          throw Exception('Unexpected response format: $responseData');
        }
      } else {
        throw Exception(
            'Failed to patch mentor introduction: ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
