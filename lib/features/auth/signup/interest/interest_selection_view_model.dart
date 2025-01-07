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
  bool isMenteeSignSuccess = false;

  InterestSelectionViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    role = await _secureStorage.readRole();

    log("InterestSelectionViewModel 로컬 저장소 $role");
    notifyListeners();
  }

  void selectInterest(Interest interest) async {
    log(interest.name);
    selectedInterest = interest;

    await _secureStorage.saveInterest(interest.name);
    notifyListeners();
  }

  Future<void> signUpMentee(Interest interest) async {
    try {
      //잘 전송이 되어야 넘어감
      await userService.signUpMentee(interest.name);
      isMenteeSignSuccess = true;

      notifyListeners();
    } catch (e) {
      log("Exception occurred: $e");
      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      notifyListeners();
    }
  }
}
