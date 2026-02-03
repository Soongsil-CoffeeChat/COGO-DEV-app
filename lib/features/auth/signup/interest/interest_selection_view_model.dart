import 'dart:developer';

import 'package:cogo/common/enums/interest.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class InterestSelectionViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  String? role;
  Interest? selectedInterest;

  InterestSelectionViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    role = await _secureStorage.readRole();
    log("InterestSelectionViewModel 로컬 저장소 역할: $role");
    notifyListeners();
  }

  Future<void> selectInterest(Interest interest) async {
    log("Selected Interest: ${interest.name}");
    selectedInterest = interest;
    await _secureStorage.saveInterest(interest.name);
    notifyListeners();
  }

  // 성공/실패 여부를 리턴 (Future<bool>)
  Future<bool> signUpMentee(Interest interest) async {
    try {
      await userService.signUpMentee(interest.name);
      notifyListeners();
      return true; // 성공
    } catch (e) {
      log("Exception occurred: $e");
      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      notifyListeners();
      return false; // 실패
    }
  }
}