import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/domain/entity/my_page_info.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class MypageViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  final UserService userService = GetIt.instance<UserService>();
  final ImagePicker _picker = ImagePicker();

  MypageUiState _state = const MypageUiState();
  MypageUiState get state => _state;

  bool _isUploading = false;
  bool get isUploading => _isUploading;

  String? _uploadError;
  String? get uploadError => _uploadError;

  MypageViewModel() {
    initialize();
  }

  void initialize() {
    fetchUserData();
  }

  /// 바텀 네비게이션 탭 재클릭 시 호출 (강제 새로고침)
  Future<void> refreshMyPage() async {
    log("Mypage Tab Refreshed (재빌드 요청)");
    await fetchUserData();
  }

  Future<void> fetchUserData() async {
    _updateState(isLoading: true, hasError: false);

    try {
      log("내 정보 불러오는 중...");
      final response = await userService.getUserInfo();
      final data = MyPageInfo.fromResponse(response);
      _updateState(myPageInfo: data);
      log('내 정보 조회 성공: ${data.name}');
    } catch (e) {
      log('Error fetching user data: $e');
      _updateState(hasError: true);
    } finally {
      _updateState(isLoading: false);
    }
  }

  /// 이미지 선택 후 바로 서버에 업로드
  Future<void> pickAndUpload(
    ImageSource source, {
    VoidCallback? onSuccess,
  }) async {
    _uploadError = null;
    notifyListeners();

    try {
      final XFile? file = await _picker.pickImage(source: source);
      if (file == null) return;

      _isUploading = true;
      notifyListeners();

      final bool isSuccess = await userService.saveImage(file.path);

      if (isSuccess) {
        onSuccess?.call();
      } else {
        _uploadError = '업로드에 실패했습니다.';
      }
    } catch (e) {
      log('이미지 업로드 오류: $e');
      _uploadError = '오류가 발생했습니다.';
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    await _secureStorage.deleteAllData();
  }

  Future<void> signOut(BuildContext context) async {
    await userService.signOut();
    await _secureStorage.deleteAllData();
  }

  void clearUploadError() {
    _uploadError = null;
    notifyListeners();
  }

  void _updateState({
    bool? isLoading,
    bool? hasError,
    MyPageInfo? myPageInfo,
    String? role,
  }) {
    _state = _state.copyWith(
      isLoading: isLoading,
      hasError: hasError,
      myPageInfo: myPageInfo,
      role: role,
    );
    notifyListeners();
  }
}

class MypageUiState {
  final bool isLoading;
  final bool hasError;
  final MyPageInfo? myPageInfo;

  const MypageUiState({
    this.isLoading = false,
    this.hasError = false,
    this.myPageInfo,
  });

  MypageUiState copyWith({
    bool? isLoading,
    bool? hasError,
    MyPageInfo? myPageInfo,
    String? role,
  }) {
    return MypageUiState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      myPageInfo: myPageInfo ?? this.myPageInfo,
    );
  }
}
