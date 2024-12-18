import 'dart:developer';
import 'dart:io';

import 'package:cogo/data/service/s3_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadViewModel extends ChangeNotifier {
  final S3Service s3service = GetIt.instance<S3Service>();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _isUploading = false;
  String? _errorMessage;

  File? get selectedImage => _selectedImage;

  bool get isUploading => _isUploading;

  String? get errorMessage => _errorMessage;

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = "Error picking image: $e";
      notifyListeners();
    }
  }

  Future<void> uploadToS3() async {
    if (_selectedImage == null) {
      _errorMessage = "Please select an image first.";
      notifyListeners();
      return;
    }

    try {
      String fileName = _selectedImage!.path.split('/').last;
      log("fileName: $fileName");

      try {
        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(
            _selectedImage!.path,
            filename: fileName,
          ),
        });

        log("FormData 생성됨");
        log("파일 경로: ${_selectedImage!.path}");
        log("파일 존재 여부: ${File(_selectedImage!.path).existsSync()}");

        // FormData 내부 데이터 출력
        formData.fields.forEach((field) {
          log("Field: ${field.key}, Value: ${field.value}");
        });

        s3service.saveImage(formData);
        _isUploading = true;
        notifyListeners();
      } catch (e) {
        log("FormData 생성 중 오류 발생: $e");
      }
    } catch (e) {
      _errorMessage = "Error uploading image: $e";
      notifyListeners();
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}
