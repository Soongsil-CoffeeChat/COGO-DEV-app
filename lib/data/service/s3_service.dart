import 'dart:developer';
import 'dart:io';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/image_save_response.dart';
import 'package:dio/dio.dart';

class S3Service {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  // s3 이미지 저장
  Future<ImageSaveResponse> saveImage(File selectedImage) async {
    try {
      String fileName = selectedImage.path.split('/').last;
      log("fileName: $fileName");

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          selectedImage.path,
          filename: fileName,
        ),
      });

      log("formData: ${formData.files.length}");

      final response = await _apiClient.dio.post(
          options: Options(
            extra: {'skipAuthToken': false, 'multipart': true}, //토큰 해제하지 않음
          ),
          '${Apis.s3}/v2',
          data: {'image': formData.files});

      if (response.statusCode == 201) {
        //base response로 받는건 여기서 뿐임.
        final baseResponse = BaseResponse<ImageSaveResponse>.fromJson(
          response.data,
          (contentJson) => ImageSaveResponse.fromJson(contentJson),
        );
        return baseResponse.content;
      } else {
        throw Exception('Failed to send verification code');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      // 기타 모든 예외 처리
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
