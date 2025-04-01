import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/image_save_response.dart';
import 'package:dio/dio.dart';

class S3Service {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  Future<String?> uploadImage(String imagePath) async {
    try {
      const url = '$apiVersion${Apis.s3}/v2';

      // FormData 생성
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath,
            filename: imagePath.split('/').last)
      });

      // 요청 전송
      final response = await _apiClient.dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'accept': '*/*',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // 상태 코드 확인
      if (response.statusCode != 201) {
        throw Exception('업로드 실패: 상태 코드 = ${response.statusCode}');
      }

      final baseResponse = BaseResponse<ImageSaveResponse>.fromJson(
        response.data,
        (contentJson) => ImageSaveResponse.fromJson(contentJson),
      );
      return baseResponse.content.savedUrl;
    } on DioException catch (e) {
      // Dio 특화된 에러 처리
      throw Exception('업로드 중 오류 발생: ${e.response?.data ?? e.message}');
    } catch (e) {
      // 기타 예외 처리
      throw Exception('업로드 중 오류 발생: ${e.toString()}');
    }
  }
}
