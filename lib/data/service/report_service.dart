import 'dart:developer';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:dio/dio.dart';

class ReportService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  /// 사용자 리포트 등록하기
  Future<bool> postReportUser(int reporterId, int reportedUserId, String reason, String additionalDetails) async {
    try {
      final response = await _apiClient.dio.post(
        apiVersion + Apis.report,
        data: {
          'reporterId': reporterId,
          'reportedUserId': reportedUserId,
          'reason': reason,
          "otherReason": "string",
          'additionalDetails': additionalDetails,
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
}
