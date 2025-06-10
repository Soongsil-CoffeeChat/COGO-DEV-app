import 'dart:developer';
import 'package:cogo/common/enums/login_platform.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService authService = GetIt.instance<AuthService>();

  LoginPlatform _loginPlatform = LoginPlatform.none;
  String? _errorMessage;
  String? loginStatus;

  LoginPlatform get loginPlatform => _loginPlatform;
  String? get errorMessage => _errorMessage;

  LoginViewModel();

  /// 현재 플랫폼이 iOS인지 확인 (웹 제외)
  bool get isIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// 현재 플랫폼이 Android인지 확인
  bool get isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// 현재 플랫폼이 웹인지 확인
  bool get isWeb => kIsWeb;

  Future<void> signInWithGoogle() async {
    // 플랫폼별 clientId 분기
    String? clientId;

    if (kIsWeb) {
      clientId =
          '1095380753268-s8v7j2b0vh4g3dm68ct5qa2vkkc16itm.apps.googleusercontent.com'; // 웹 전용 ID
    } else {
      clientId = dotenv.get("CLIENT_ID", fallback: null); // 모바일용 .env 설정
    }

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: clientId, // null이면 Android에서 자동 처리됨
      scopes: ['email', 'profile'],
    );

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
        final response =
            await authService.getGoogleAccessToken(authCode!, name!);
        await _saveUserInfo(name, googleUser.email);
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

  Future<void> signInWithApple() async {
    if (!isIOS) return;

    try {
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: "cogoDevApp.example.com",
          redirectUri: Uri.parse(dotenv.get("redirect_uri")),
        ),
      );

      print('credential.email = ${credential.email}');
      print('credential.userIdentifier = ${credential.userIdentifier}');

      final authCode = credential.identityToken;

      final response = await authService.getAppleAccessToken(authCode!);

      await _saveUserInfo(credential.givenName, credential.email);
      _loginPlatform = LoginPlatform.apple;

      loginStatus = response.accountStatus;
      notifyListeners();
    } catch (e) {
      log("Exception occurred: $e");
      _errorMessage = 'Apple 로그인에 실패했습니다. 다시 시도해주세요.';

      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      notifyListeners();
      rethrow;
    }
  }

  Future<void> _saveUserInfo(String? name, String? email) async {
    final SecureStorageRepository secureStorage = SecureStorageRepository();
    secureStorage.saveUserName(name ?? '');
    secureStorage.saveUserEmail(email ?? '');
  }

  Future<void> signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.apple:
        // TODO: Apple 로그아웃 처리 필요 시 구현
        break;
      case LoginPlatform.none:
        break;
    }

    _loginPlatform = LoginPlatform.none;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
