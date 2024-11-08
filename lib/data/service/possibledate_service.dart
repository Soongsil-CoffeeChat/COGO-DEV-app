import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/mentor_possible_date_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

class PossibledateService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  //TODO : 추후 실제 유저 토큰으로 바꿔야 함
  String token = FlutterConfig.get('mentor_token');

  Future<MentorPossibleDateResponse> getMentorPossibleDates(
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

        // JSON 데이터의 content가 null인 경우
        if (responseData is Map<String, dynamic> &&
            responseData['content'] != null) {
          final contentJson = responseData['content'] as Map<String, dynamic>;
          return MentorPossibleDateResponse.fromJson(contentJson);
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
}
