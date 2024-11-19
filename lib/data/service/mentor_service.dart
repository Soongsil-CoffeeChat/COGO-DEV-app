import 'dart:developer';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/mentor_detail_response.dart';
import 'package:cogo/data/dto/response/mentor_introduction_response.dart';
import 'package:cogo/data/dto/response/mentor_part_response.dart';
import 'package:dio/dio.dart';

class MentorService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  Future<MentorDetailResponse> getMentorDetail(int mentorId) async {
    try {
      final response = await _apiClient.dio.get(
        '$apiVersion${Apis.mentor}/$mentorId',
        options: Options(
          extra: {'skipAuthToken': false},
        ),
      );
      if (response.statusCode == 200) {
        final responseData = response.data;

        // JSON 데이터의 content가 null인 경우
        if (responseData is Map<String, dynamic> &&
            responseData['content'] != null) {
          final contentJson = responseData['content'] as Map<String, dynamic>;
          return MentorDetailResponse.fromJson(contentJson);
        } else {
          throw Exception(
              'Unexpected response format or null content: $responseData');
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

  // 파트별 멘토리스트 호출
  Future<List<MentorPartResponse>> getMentorPart(String part) async {
    try {
      final response = await _apiClient.dio.get(
        apiVersion + Apis.mentorPart,
        options: Options(
          extra: {'skipAuthToken': false},
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
