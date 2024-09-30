import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:dio/dio.dart';

class RefreshService {
  final ApiClient _apiClient = ApiClient();

// POST /auth/reissue/mobile -리소스 서버에서 받은 accessToken으로 서비스 accessToken 발급
  Future<String> getAccessToken(String authCode) async {
    try {
      final response = await _apiClient.dio.get(
        Apis.getAccessToken,
        queryParameters: {
          'accessToken': authCode,
        },
      );
      if (response.statusCode == 200) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<String>.fromJson(
          response.data,
          (contentJson) => contentJson.toString(),
        );
        return baseResponse.content;
      } else {
        throw Exception('Failed to send verification code');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    }
  }
}
