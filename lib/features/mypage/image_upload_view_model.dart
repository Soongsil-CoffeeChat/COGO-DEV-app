import 'dart:io';

import 'package:cogo/data/service/s3_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageUploadViewModel extends ChangeNotifier {
  final S3Service s3service = GetIt.instance<S3Service>();
  final UserService userService = GetIt.instance<UserService>();

  final ImagePicker _picker = ImagePicker();

  List<AssetEntity> _assets = [];
  AssetEntity? _selectedAsset;

  bool _isUploading = false;
  String? _errorMessage;
  String? _uploadResult;
  bool _isUpload = false;

  List<AssetEntity> get assets => _assets;
  AssetEntity? get selectedAsset => _selectedAsset;
  bool get isUploading => _isUploading;
  String? get errorMessage => _errorMessage;
  bool get isUpload => _isUpload;

  ImageUploadViewModel() {
    _fetchAssets();
  }

  Future<void> _fetchAssets() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    print('Permission state: $ps');
    print('Is auth: ${ps.isAuth}');

    if (!ps.isAuth) {
      print('Permission denied');
      return;
    }

    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    print('Albums count: ${albums.length}');

    if (albums.isEmpty) {
      print('No albums found');
      return;
    }

    final List<AssetEntity> media =
        await albums.first.getAssetListPaged(page: 0, size: 100);

    print('Media count: ${media.length}');

    _assets = media;
    notifyListeners();
  }

  void toggleSelection(AssetEntity asset) {
    if (_selectedAsset == asset) {
      _selectedAsset = null;
    } else {
      _selectedAsset = asset;
    }
    notifyListeners();
  }

  bool isSelected(AssetEntity asset) {
    return _selectedAsset == asset;
  }

  /// 이미지 업로드
  Future<void> uploadImage({VoidCallback? onSuccess}) async {
    if (_selectedAsset == null) {
      _errorMessage = '먼저 이미지를 선택해주세요.';
      notifyListeners();
      return;
    }

    try {
      _isUploading = true;
      _errorMessage = null;
      notifyListeners();

      final imageFile = await _selectedAsset!.file;

      if (imageFile == null) {
        _errorMessage = '이미지 파일을 불러올 수 없습니다.';
        _isUploading = false;
        notifyListeners();
        return;
      }

      _isUpload = await userService.saveImage(imageFile.path);

      _isUploading = false;
      notifyListeners();

      // 성공 콜백 실행
      if (_isUpload && onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isUploading = false;
      notifyListeners();
    }
  }

  /// 카메라 촬영 후 이미지 리스트에 추가
  Future<void> pickFromCamera(BuildContext context) async {
    final XFile? cameraImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (cameraImage != null) {
      Navigator.pop(context, [File(cameraImage.path)]);
    }
  }
}
