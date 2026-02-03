import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/domain/entity/my_page_info.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MypageViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  final UserService userService = GetIt.instance<UserService>();

  MypageUiState _state = const MypageUiState();
  MypageUiState get state => _state;

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
    // 1. 로딩 시작: UI를 로딩 상태로 변경하여 화면 갱신 유도
    _updateState(isLoading: true, hasError: false);

    try {
      log("내 정보 불러오는 중...");
      final response = await userService.getUserInfo();
      final data = MyPageInfo.fromResponse(response);

      // 데이터 업데이트
      _updateState(myPageInfo: data);
      log('내 정보 조회 성공: ${data.name}');
    } catch (e) {
      log('Error fetching user data: $e');
      _updateState(hasError: true);
    } finally {
      // 2. 로딩 종료: UI를 데이터 표시 상태로 변경
      _updateState(isLoading: false);
    }
  }

  Future<void> logOut() async {
    await _secureStorage.deleteAllData();
  }

  Future<void> signOut(BuildContext context) async {
    await userService.signOut();
    await _secureStorage.deleteAllData();
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