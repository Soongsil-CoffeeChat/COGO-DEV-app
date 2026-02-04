import 'dart:io';

import 'package:cogo/data/service/s3_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadViewModel extends ChangeNotifier {
  final S3Service s3service = GetIt.instance<S3Service>();
  final UserService userService = GetIt.instance<UserService>();

  final ImagePicker _picker = ImagePicker();

  File? _selectedFile;

  bool _isUploading = false;
  String? _errorMessage;

  // Getters
  File? get selectedFile => _selectedFile;
  bool get isUploading => _isUploading;
  String? get errorMessage => _errorMessage;

  ImageUploadViewModel();

  /// 갤러리에서 사진 선택 (권한 필요 없음 - Photo Picker 사용)
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _selectedFile = File(image.path);
        _errorMessage = null;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = "사진을 불러오지 못했습니다.";
      notifyListeners();
    }
  }

  /// 카메라로 사진 촬영
  Future<void> pickFromCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        _selectedFile = File(photo.path);
        _errorMessage = null;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = "카메라를 실행하지 못했습니다.";
      notifyListeners();
    }
  }

  /// 이미지 선택 취소 (X 버튼 기능 등)
  void clearImage() {
    _selectedFile = null;
    notifyListeners();
  }

  /// 이미지 업로드 실행
  Future<void> uploadImage({VoidCallback? onSuccess}) async {
    if (_selectedFile == null) {
      _errorMessage = '먼저 이미지를 선택해주세요.';
      notifyListeners();
      return;
    }

    try {
      _isUploading = true;
      _errorMessage = null;
      notifyListeners();

      // UserService를 통해 업로드 요청
      final bool isSuccess = await userService.saveImage(_selectedFile!.path);

      _isUploading = false;
      notifyListeners();

      if (isSuccess) {
        if (onSuccess != null) {
          onSuccess();
        }
      } else {
        _errorMessage = '업로드에 실패했습니다.';
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = '오류가 발생했습니다: $e';
      _isUploading = false;
      notifyListeners();
    }
  }
}