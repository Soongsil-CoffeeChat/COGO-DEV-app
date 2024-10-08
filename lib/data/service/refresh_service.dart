import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:dio/dio.dart';

class RefreshService {
  final ApiClient _apiClient = ApiClient();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

// POST /auth/reissue/mobile -리소스 서버에서 받은 accessToken으로 서비스 accessToken 발급
  Future<String> getAccessToken(String authCode) async {
    try {
      final response = await _apiClient.dio.post(
        options: Options(
          extra: {'skipAuthToken': true}, //토큰 해제
        ),
        Apis.getAccessToken,
        queryParameters: {
          'accessToken': authCode,
        },
      );
      if (response.statusCode == 200) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<String>.fromJson(
          response.data as Map<String, dynamic>,
          (contentJson) => contentJson.toString(),
        );
        await _secureStorage.writeData('auth_token', baseResponse.content);
        return baseResponse.content;
      } else {
        throw Exception(
            'Failed to send verification code ${response.data.toString()}');
      }
    } on DioException catch (e) {
      //애로 감 다
      throw Exception('Error: ${e.response?.data.toString() ?? e.message}');
    }
  }
}
