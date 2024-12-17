import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MentorInfoViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  String? _name = "";

  String? get name => _name;

  String? _selectedInterest = "";

  String? get selectedInterest => _selectedInterest;

  String? _selectedClub = "";

  String? get selectedClub => _selectedClub;

  bool _isSignUpSuccessful = false;
  bool get isSignUpSuccessful => _isSignUpSuccessful;

  String? _errorMessage = "";
  String? get errorMessage => _errorMessage;

  MentorInfoViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    _name = await _secureStorage.readUserName();
    _selectedInterest = await _secureStorage.readInterest();
    _selectedClub = await _secureStorage.readClub();

    log("MentorInfoViewModel $name $selectedInterest $selectedClub");
    notifyListeners(); //비동기 함수일 때, 데이터가 모두 로드된 후에 호출해야 합니다.
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
