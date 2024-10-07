import 'dart:developer';

import 'package:cogo/common/enums/login_platform.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/refresh_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends ChangeNotifier {
  final RefreshService refreshService;

  LoginPlatform _loginPlatform = LoginPlatform.none;

  LoginPlatform get loginPlatform => _loginPlatform;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  LoginViewModel({required this.refreshService});

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      log('name = ${googleUser.displayName}');
      log('email = ${googleUser.email}');
      log('id = ${googleUser.id}');

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      log("토큰: ${googleSignInAuthentication.accessToken}");

      final authCode = googleSignInAuthentication.accessToken;

      try {
        final result = await refreshService.getAccessToken(authCode!);

        await _saveUserInfo(googleUser.displayName, googleUser.email, result);
        _loginPlatform = LoginPlatform.google;

        notifyListeners();
      } catch (e) {
        log("Exception occurred: $e");
        _errorMessage = 'Google 로그인에 실패했습니다. 다시 시도해주세요.';

        if (e is DioException) {
          log("DioError details: ${e.response?.data}");
        }
        notifyListeners();
      }

      notifyListeners();
    }
  }

  Future<void> _saveUserInfo(
      String? name, String email, String accessToken) async {
    final SecureStorageRepository secureStorage = SecureStorageRepository();

    secureStorage.writeData('access_token', accessToken);
    secureStorage.writeData('user_name', name ?? '');
    secureStorage.writeData('user_email', email);
  }

  Future<void> signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut(); //현재는 구글로그인만 지원
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
    }

    _loginPlatform = LoginPlatform.none;
    notifyListeners();
  }

  // 에러 메시지 초기화
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
