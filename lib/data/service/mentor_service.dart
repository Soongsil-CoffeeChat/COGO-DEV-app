import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/mentor_detail_response.dart';
import 'package:dio/dio.dart';

class MentorService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  Future<MentorDetailResponse> getMentorDetail(String mentorId) async {
    try {
      final response = await _apiClient.dio.get(
        queryParameters: {
          'mentorId': mentorId,
        },
        options: Options(
          extra: {'skipAuthToken': false}, //토큰 해제
        ),
        apiVersion + Apis.signUpMentor,
      );
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse<MentorDetailResponse>.fromJson(
          response.data,
              (contentJson) => MentorDetailResponse.fromJson(contentJson),
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