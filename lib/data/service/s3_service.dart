import 'dart:developer';

import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/image_save_response.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

import '../../../constants/apis.dart';

class S3Service {
  final Dio _dio = Dio();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  S3Service();

  Future<String?> uploadImage(String imagePath) async {
    try {
      // API 엔드포인트 URL
      const apiVersion = "api/v2/";
      final url = '${FlutterConfig.get("base_url")}$apiVersion${Apis.s3}/v2';

      // 토큰 가져오기
      var token = await _secureStorage.readAccessToken();

      // FormData 생성
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath,
            filename: imagePath.split('/').last)
      });

      // Dio 요청 옵션 설정
      final options = Options(
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      // 요청 전송
      final response = await _dio.post(
        url,
        data: formData,
        options: options,
      );

      // Log Interceptor 추가
      _dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) {
          log("서버통신 $obj");
        },
      ));

      if (response.statusCode == 201) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<ImageSaveResponse>.fromJson(
          response.data,
          (contentJson) => ImageSaveResponse.fromJson(contentJson),
        );
        return baseResponse.content.savedUrl;
      } else {
        throw Exception('서버 통신 실패 ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Dio 특화된 에러 처리
      throw Exception('업로드 중 오류 발생: ${e.response?.data ?? e.message}');
    } catch (e) {
      // 기타 예외 처리
      throw Exception('업로드 중 오류 발생: ${e.toString()}');
    }
  }
}