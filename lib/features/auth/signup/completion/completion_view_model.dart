import 'dart:developer';

import 'package:cogo/common/enums/role.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CompletionViewModel extends ChangeNotifier {
  final AuthService authService = GetIt.instance<AuthService>();

  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  String? role;
  bool isLoading = true;

  CompletionViewModel() {
    _loadPreferences();
  }

  /// 회원가입 완료 후 바로 토큰 재발급
  Future<void> refreshToken() async {
    await authService.reissueToken();
  }

  void _loadPreferences() async {
    role = await _secureStorage.readRole();
    isLoading = false;
    notifyListeners();
  }
}
