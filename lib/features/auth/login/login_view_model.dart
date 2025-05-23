import 'dart:developer';

import 'package:cogo/common/enums/login_platform.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;

class LoginViewModel extends ChangeNotifier {
  final AuthService authService = GetIt.instance<AuthService>();

  LoginPlatform _loginPlatform = LoginPlatform.none;

  LoginPlatform get loginPlatform => _loginPlatform;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? loginStatus;

  LoginViewModel();

  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = Platform.isIOS
        ? GoogleSignIn(
            clientId: dotenv.get("CLIENT_ID"),
            scopes: ['email', 'profile'],
          )
        : GoogleSignIn();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      log('name = ${googleUser.displayName}');
      log('email = ${googleUser.email}');
      log('id = ${googleUser.id}');

      final name = googleUser.displayName;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      log("토큰: ${googleSignInAuthentication.accessToken}");

      final authCode = googleSignInAuthentication.accessToken;

      try {
        final response = await authService.getAccessToken(authCode!, name!);

        await _saveUserInfo(googleUser.displayName, googleUser.email);
        _loginPlatform = LoginPlatform.google;

        loginStatus = response.accountStatus;
        log("로그인상태: $loginStatus");

        notifyListeners();
      } catch (e) {
        log("Exception occurred: $e");
        _errorMessage = 'Google 로그인에 실패했습니다. 다시 시도해주세요.';

        if (e is DioException) {
          log("DioError details: ${e.response?.data}");
        }
        notifyListeners();
      }
    }
  }

  Future<void> _saveUserInfo(String? name, String email) async {
    final SecureStorageRepository secureStorage = SecureStorageRepository();
    secureStorage.saveUserName(name ?? '');
    secureStorage.saveUserEmail(email);
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
