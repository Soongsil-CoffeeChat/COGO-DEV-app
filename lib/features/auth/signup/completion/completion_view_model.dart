import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/refresh_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class CompletionViewModel extends ChangeNotifier {
  final RefreshService refreshService = GetIt.instance<RefreshService>();

  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  String? role;
  bool isLoading = true;

  CompletionViewModel() {
    _loadPreferences();
  }

  /// 회원가입 완료 후 바로 토큰 재발급
  Future<void> refreshToken() async {
    await refreshService.reissueToken();
  }

  void _loadPreferences() async {
    role = await _secureStorage.readRole();
    isLoading = false;
    notifyListeners();
  }
}
