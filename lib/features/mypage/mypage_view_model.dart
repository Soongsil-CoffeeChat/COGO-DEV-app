import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/fcm_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/domain/entity/my_page_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class MypageViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  final UserService userService = GetIt.instance<UserService>();
  final FcmService fcmService = GetIt.instance<FcmService>();
  final ImagePicker _picker = ImagePicker();

  MypageUiState _state = const MypageUiState();
  MypageUiState get state => _state;

  bool _isUploading = false;
  bool get isUploading => _isUploading;

  String? _uploadError;
  String? get uploadError => _uploadError;

  bool _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;

  MypageViewModel() {
    initialize();
  }

  void initialize() {
    fetchUserData();
    _loadNotificationStatus();
  }

  Future<void> _loadNotificationStatus() async {
    if (kIsWeb) return;
    final settings =
        await FirebaseMessaging.instance.getNotificationSettings();
    _isNotificationEnabled =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional;
    notifyListeners();
  }

  /// 알림 토글
  Future<void> setNotificationEnabled(bool value) async {
    if (kIsWeb) return;

    if (value) {
      final settings =
          await FirebaseMessaging.instance.getNotificationSettings();

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        // 권한 거부 상태 → 시스템 설정 열기
        AppSettings.openAppSettings(type: AppSettingsType.notification);
        return;
      }

      if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
        final newSettings =
            await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
        if (newSettings.authorizationStatus != AuthorizationStatus.authorized &&
            newSettings.authorizationStatus != AuthorizationStatus.provisional) {
          return;
        }
      }

      // 권한 있음 → 토큰 등록
      await _registerFcmToken();
      _isNotificationEnabled = true;
    } else {
      // 토글 OFF → 로컬 토큰 삭제
      try {
        await FirebaseMessaging.instance.deleteToken();
        log('[FCM] 토큰 삭제 완료');
      } catch (e) {
        log('[FCM] 토큰 삭제 실패: $e');
      }
      _isNotificationEnabled = false;
    }
    notifyListeners();
  }

  Future<void> refreshNotificationStatus() async {
    await _loadNotificationStatus();
  }

  Future<void> _registerFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await fcmService.registerFcmToken(token);
        log('[FCM] 마이페이지 토글 - 토큰 서버 등록 완료');
      }
    } catch (e) {
      log('[FCM] 토큰 재등록 실패: $e');
    }
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

  /// 이미지 선택 즉시 onPicked 호출(바텀시트 닫기) → 백그라운드로 업로드
  Future<void> pickAndUpload(
    ImageSource source, {
    VoidCallback? onPicked,
  }) async {
    _uploadError = null;
    notifyListeners();

    try {
      final XFile? file = await _picker.pickImage(source: source);
      if (file == null) return;

      // 이미지 선택 완료 → 바텀시트 즉시 닫기
      onPicked?.call();

      _isUploading = true;
      notifyListeners();

      final bool isSuccess = await userService.saveImage(file.path);
      if (!isSuccess) {
        _uploadError = '업로드에 실패했습니다.';
      } else {
        await _silentRefresh();
      }
    } catch (e) {
      log('이미지 업로드 오류: $e');
      _uploadError = '오류가 발생했습니다.';
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

  /// 페이지 로딩 상태 없이 조용히 데이터만 갱신 (업로드 후 사용)
  Future<void> _silentRefresh() async {
    try {
      final response = await userService.getUserInfo();
      _updateState(myPageInfo: MyPageInfo.fromResponse(response));
    } catch (e) {
      log('Silent refresh 실패: $e');
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
