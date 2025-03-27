import 'dart:io';

import 'package:cogo/data/service/s3_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadViewModel extends ChangeNotifier {
  final S3Service s3service = GetIt.instance<S3Service>();
  final UserService userService = GetIt.instance<UserService>();

  File? _selectedImage;
  bool _isUploading = false;
  bool _isUpload = false;
  String? _uploadResult;
  String? _errorMessage;

  // 생성자
  ImageUploadViewModel();

  // Getters
  File? get selectedImage => _selectedImage;
  bool get isUploading => _isUploading;

  bool get isUpload => _isUpload;
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

      // 서비스를 통해 이미지 업로드
      _uploadResult = await s3service.uploadImage(_selectedImage!.path);

      // 업로드 성공
      _isUpload = await userService.saveImage(_uploadResult!);
      _isUploading = false;
      notifyListeners();
    } catch (e) {
      // 에러 처리
      _errorMessage = e.toString();
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