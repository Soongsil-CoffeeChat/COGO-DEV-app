import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/mentor_detail_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';


class MentorService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  String token = FlutterConfig.get('mentor_token'); // .env 파일에서 가져오기

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
}