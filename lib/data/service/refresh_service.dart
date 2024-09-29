import 'package:cogo/data/di/api_client.dart';
import 'package:dio/dio.dart';

import '../../constants/apis.dart';
import '../dto/base_response.dart';
import '../dto/token.dart';

class RefreshService {
  final ApiClient _apiClient = ApiClient();

// POST /auth/reissue/mobile -리소스 서버에서 받은 accessToken으로 서비스 accessToken 발급
  Future<Token> getAccessToken(String authCode) async {
    try {
      final response = await _apiClient.dio.get(
        Apis.getAccessToken,
        queryParameters: {
          'accessToken ': authCode,
        },
      );
      if (response.statusCode == 200) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<Token>.fromJson(
          response.data,
          (contentJson) => Token.fromJson(contentJson),
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
