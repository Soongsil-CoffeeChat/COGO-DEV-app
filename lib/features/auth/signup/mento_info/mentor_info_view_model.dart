import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MentorInfoViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  String? name;
  String? selectedInterest;
  String? selectedClub;

  bool _isSignUpSuccessful = false;

  bool get isSignUpSuccessful => _isSignUpSuccessful;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  MentorInfoViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    notifyListeners();

    name = await _secureStorage.readUserName();
    selectedInterest = await _secureStorage.readInterest();
    selectedClub = await _secureStorage.readClub();
  }

  ///멘토로 가입 api 호출
  Future<void> signUpMentor() async {
    try {
      //잘 전송이 되어야 넘어감
      await userService.signUpMentor(selectedInterest!, selectedClub!);
      _isSignUpSuccessful = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = '멘토 회원가입이 실패하였습니다. 다시 시도해주세요.';

      log("Exception occurred: $e");
      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      notifyListeners();
    }
  }

  // 에러 메시지 초기화
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
