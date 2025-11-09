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

  List<AssetEntity> get assets => _assets;
  AssetEntity? get selectedAsset => _selectedAsset;

  ImageUploadViewModel() {
    _fetchAssets();
  }

  Future<void> _fetchAssets() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    print('Permission state: $ps'); // 디버그 로깅
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

  /// 카메라 촬영 후 이미지 리스트에 추가
  Future<void> pickFromCamera(BuildContext context) async {
    final XFile? cameraImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (cameraImage != null) {
      Navigator.pop(context, [File(cameraImage.path)]);
    }
  }
}
