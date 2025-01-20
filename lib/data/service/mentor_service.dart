import 'dart:developer';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/edit_mentor_detail_response.dart';
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

  /// 파트별 멘토리스트 호출
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
        final baseResponse = BaseResponse<List<MentorPartResponse>>.fromJson(
          response.data,
          (contentJson) {
            return (contentJson as List)
                .map((item) => MentorPartResponse.fromJson(item))
                .toList();
          },
        );
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

  ///멘토 자기소개 입력
  Future<bool> patchMentorIntroduction(
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
        options: Options(),
      );

      if (response.statusCode != 200) {
        log(response.data.toString());

        return false;
      } else {
        return true;
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// 토큰으로 멘토 자기소개 항목 4개 조회
  Future<MentorIntroductionResponse> fetchMentorIntroduction() async {
    try {
      final response = await _apiClient.dio.get(
        apiVersion + Apis.mentorIntroduction,
        options: Options(),
      );

      log("fetchMentorIntroduction response.statusCode" +
          response.statusCode.toString());

      if (response.statusCode == 200) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<MentorIntroductionResponse>.fromJson(
          response.data,
          (contentJson) => MentorIntroductionResponse.fromJson(contentJson),
        );
        return baseResponse.content;
      } else {
        log("에러발생" + response.statusCode.toString());

        throw Exception(
            'Failed to patch mentor introduction: ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// 멘토 세부 정보 수정
  Future<EditMentorDetailResponse> patchEditMentorDetail(
      String mentorName, String mentorPhoneNumber, String mentorEmail) async {
    try {
      final response = await _apiClient.dio.patch(
        apiVersion + Apis.mentor,
        data: {
          'mentor_name': mentorName,
          'mentor_phone_number': mentorPhoneNumber,
          'mentor_email': mentorEmail,
        },
        options: Options(),
      );

      log('상태코드: $response.statusCode');
      if (response.statusCode == 200) {
        log(response.data.toString());

        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData['content'] != null) {
          final contentJson = responseData['content'] as Map<String, dynamic>;
          return EditMentorDetailResponse.fromJson(contentJson);
        } else {
          throw Exception(
              'Unexpected response format or null content: $responseData');
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
