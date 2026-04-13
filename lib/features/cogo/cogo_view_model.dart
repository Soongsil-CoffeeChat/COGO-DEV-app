import 'dart:developer';

import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class CogoViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  final UserService _userService = GetIt.instance<UserService>();

  String? _role;
  String? get role => _role;

  CogoViewModel() {
    getRole();
  }

  /// 탭을 다시 눌렀을 때 호출되는 메서드
  Future<void> refreshCogo() async {
    log("Cogo Tab Refreshed");
    await getRole();
  }

  Future<void> getRole() async {
    try {
      _role = await _secureStorage.readRole();
      // 스토리지에 role 없으면 서버에서 직접 조회 (로그인 직후 등)
      if (_role == null) {
        final response = await _userService.getUserInfo();
        _role = response.role;
        if (_role != null) {
          await _secureStorage.saveRole(_role);
        }
      }
      log("Current Role: $_role");
      notifyListeners();
    } catch (e) {
      log('Error fetching role: $e');
      notifyListeners();
    }
  }

  /// 로그아웃 시 인메모리 상태 초기화
  void reset() {
    _role = null;
    notifyListeners();
  }

  void navigateToReceivedCogo(BuildContext context) {
    context.safePush(Paths.unMatchedCogo);
  }

  void navigateToSuccessedCogo(BuildContext context) {
    context.safePush(Paths.matchedCogo);
  }
}