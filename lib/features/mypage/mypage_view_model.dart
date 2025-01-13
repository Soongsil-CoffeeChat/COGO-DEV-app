import 'dart:developer';

import 'package:cogo/common/widgets/secondary_dialog.dart';
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
    _showMentorProfileDialog(context);
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

  void _showMentorProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SecondaryDialog(
          title: "정말 탈퇴하시겠어요?",
          subtitle: '탈퇴가 진행시 계정은 삭제되며, 계정은 복구되지 않습니다.',
          imagePath: 'assets/icons/3d_img/trash.png',
          firstButtonText: '취소하기',
          secondButtonText: '탈퇴하기',
          firstOnPressed: () => Navigator.of(context).pop(),
          secondOnPressed: () {
            _secureStorage.deleteAllData();
            userService.signOut();
            context.go(Paths.login);
          },
        );
      },
    );
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
