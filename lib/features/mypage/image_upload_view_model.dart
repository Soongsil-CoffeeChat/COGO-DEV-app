import 'dart:developer';
import 'dart:io';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  final Dio _dio = Dio();

  File? _selectedImage;
  bool _isUploading = false;
  String? _uploadResult;
  String? _errorMessage;

  // Getters
  File? get selectedImage => _selectedImage;
  bool get isUploading => _isUploading;
  String? get uploadResult => _uploadResult;
  String? get errorMessage => _errorMessage;

  // 갤러리에서 이미지 선택
  Future<void> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        _errorMessage = null;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = '이미지 선택 중 오류 발생: ${e.toString()}';
      notifyListeners();
    }
  }

  // 카메라로 이미지 촬영
  Future<void> takeImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        _errorMessage = null;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = '카메라 촬영 중 오류 발생: ${e.toString()}';
      notifyListeners();
    }
  }

  // 이미지 업로드
  Future<void> uploadImage() async {
    // 이미지가 선택되지 않은 경우
    if (_selectedImage == null) {
      _errorMessage = '먼저 이미지를 선택해주세요.';
      notifyListeners();
      return;
    }

    try {
      // 업로드 시작
      _isUploading = true;
      _errorMessage = null;
      notifyListeners();

      // API 엔드포인트 URL
      const apiVersion = "api/v2/";
      final url = '${FlutterConfig.get("base_url")}$apiVersion${Apis.s3}/v2';

      // 토큰 가져오기
      var token = await _secureStorage.readAccessToken();

      // FormData 생성
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(_selectedImage!.path,
            filename: _selectedImage!.path.split('/').last)
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

      // 상태 코드 확인
      if (response.statusCode != 201) {
        throw Exception('업로드 실패: 상태 코드 = ${response.statusCode}');
      }

      // 업로드 성공
      _uploadResult = response.data.toString();
      log(_uploadResult.toString());
      _isUploading = false;
      notifyListeners();
    } on DioException catch (e) {
      // Dio 특화된 에러 처리
      _errorMessage = '업로드 중 오류 발생: ${e.response?.data ?? e.message}';
      _isUploading = false;
      notifyListeners();
    } catch (e) {
      // 기타 예외 처리
      _errorMessage = '업로드 중 오류 발생: ${e.toString()}';
      _isUploading = false;
      notifyListeners();
    }
  }

  // 선택된 이미지 초기화
  void clearSelectedImage() {
    _selectedImage = null;
    _uploadResult = null;
    _errorMessage = null;
    notifyListeners();
  }
}