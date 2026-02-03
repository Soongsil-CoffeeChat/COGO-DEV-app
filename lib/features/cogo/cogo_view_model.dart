import 'dart:developer';

import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CogoViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

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
      log("Current Role: $_role");

      // [핵심] 데이터가 같더라도 notifyListeners()를 호출해야
      // Consumer를 사용하는 UI가 Rebuild 됩니다.
      notifyListeners();
    } catch (e) {
      log('Error fetching role: $e');
    }
  }

  void navigateToReceivedCogo(BuildContext context) {
    context.push(Paths.unMatchedCogo);
  }

  void navigateToSuccessedCogo(BuildContext context) {
    context.push(Paths.matchedCogo);
  }
}