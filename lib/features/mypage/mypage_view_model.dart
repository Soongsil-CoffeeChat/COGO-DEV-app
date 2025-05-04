import 'dart:developer';

import 'package:cogo/common/widgets/two_button_dialog.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/domain/entity/my_page_info.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MypageViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  final UserService userService = GetIt.instance<UserService>();

  MypageUiState _state = const MypageUiState();

  MypageUiState get state => _state;

  MypageViewModel() {
    initialize();
  }

  void initialize() async {
    await fetchUserData();
  }

  Future<void> fetchUserData() async {
    _updateState(isLoading: true, hasError: false);

    try {
      final response = await userService.getUserInfo();
      final data = MyPageInfo.fromResponse(response); // 변환하여 UserData에 저장

      _updateState(myPageInfo: data);
      log('내 정보 조회 성공');
    } catch (e) {
      log('Error fetching user data: $e');
      _updateState(hasError: true);
    } finally {
      _updateState(isLoading: false);
    }
  }

  Future<void> logOut() async {
    _secureStorage.deleteAllData();
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
