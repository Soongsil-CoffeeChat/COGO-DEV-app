import 'dart:developer';
import 'package:cogo/common/enums/login_platform.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/auth_service.dart';
import 'package:cogo/data/service/fcm_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService authService = GetIt.instance<AuthService>();
  final FcmService fcmService = GetIt.instance<FcmService>();

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
    _errorMessage = null;

    String? clientId;

    if (isIOS) {
      clientId = dotenv.get("CLIENT_ID", fallback: null);
      log("사용 중인 CLIENT_ID: $clientId"); // 디버깅용
    } else {
      clientId = null;
    }

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: clientId,
      scopes: ['email', 'profile'],
    );

    try {
      log("Google 로그인 시작...");
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      log("Google 로그인 결과: ${googleUser != null ? '성공' : '실패/취소'}");

      if (googleUser == null) {
        log('사용자가 로그인을 취소했습니다');
        _errorMessage = '로그인이 취소되었습니다.';
        notifyListeners();
        return;
      }

      log('name = ${googleUser.displayName}');
      log('email = ${googleUser.email}');
      log('id = ${googleUser.id}');

      final name = googleUser.displayName;

      log("인증 정보 가져오는 중...");
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      log("accessToken: ${googleAuth.accessToken}");
      log("idToken: ${googleAuth.idToken}");

      final authCode = googleAuth.accessToken;

      if (authCode == null || authCode.isEmpty) {
        log('❌ accessToken이 null입니다!');

        // iOS에서는 idToken을 사용해야 할 수도 있음
        final idToken = googleAuth.idToken;
        if (idToken != null && idToken.isNotEmpty) {
          log('✅ idToken은 있습니다. idToken 사용 시도');
          // 서버가 idToken을 받는다면 이것을 사용
          final response =
              await authService.getGoogleAccessToken(idToken, name!);
          await _saveUserInfo(name, googleUser.email);
          await _registerFcmToken();
          _loginPlatform = LoginPlatform.google;
          loginStatus = response.accountStatus;
          log("로그인상태: $loginStatus");
          notifyListeners();
          return;
        }

        _errorMessage = '인증 토큰을 받아오지 못했습니다. 다시 시도해주세요.';
        notifyListeners();
        return;
      }

      if (name == null || name.isEmpty) {
        log('사용자 이름을 받아오지 못했습니다');
        _errorMessage = '사용자 정보를 받아오지 못했습니다. 다시 시도해주세요.';
        notifyListeners();
        return;
      }

      log("서버에 토큰 전송 중...");
      final response = await authService.getGoogleAccessToken(authCode, name);

      await _saveUserInfo(name, googleUser.email);
      await _registerFcmToken();
      _loginPlatform = LoginPlatform.google;
      loginStatus = response.accountStatus;
      log("✅ 로그인 성공! 상태: $loginStatus");

      notifyListeners();
    } catch (e, stackTrace) {
      log("❌ Exception occurred: $e");
      log("Stack trace: $stackTrace");
      _errorMessage = 'Google 로그인에 실패했습니다. 다시 시도해주세요.';
      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signInWithApple() async {
    if (!isIOS) return;

    String redirectUri = dotenv.get("redirect_uri");
    try {
      final AuthorizationCredentialAppleID credential =
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // 1. 기본적으로 credential에서 이메일을 가져옵니다. (첫 로그인 시에만 값 있음)
      String? email = credential.email;
      String? givenName = credential.givenName;

      // 2. 만약 이메일이 null이고 identityToken이 있다면, 토큰을 디코딩해서 이메일을 추출합니다.
      if (email == null && credential.identityToken != null) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(credential.identityToken!);
        email = decodedToken['email'];
        log("identityToken에서 추출한 이메일: $email");
      }

      log('최종 이메일 = $email');
      log('authorizationCode = ${credential.authorizationCode}');

      final authCode = credential.authorizationCode;

      // 서버로 전송
      final response =
      await authService.getAppleAccessToken(authCode!, redirectUri);

      // 추출한 이메일로 저장
      await _saveUserInfo(givenName, email);
      await _registerFcmToken();

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

  /// 관리자용 테스트 로그인 (코드 검증 포함)
  Future<bool> signInTest(String inputCode) async {
    _errorMessage = null;

    try {
      log("테스트 로그인 시작...");

      // dotenv에서 관리자 코드 및 토큰 추출
      final adminCode = dotenv.get("ADMIN_CODE", fallback: null);
      final testAccessToken = dotenv.get("TEST_ACCESS_TOKEN", fallback: null);
      final testRefreshToken = dotenv.get("TEST_REFRESH_TOKEN", fallback: null);
      final testUserName = dotenv.get("TEST_USER_NAME", fallback: "관리자");
      final testUserEmail = dotenv.get("TEST_USER_EMAIL", fallback: "admin@test.com");

      // 코드 검증
      if (adminCode == null || adminCode != inputCode) {
        log('❌ 잘못된 관리자 코드');
        _errorMessage = '잘못된 관리자 코드입니다.';
        notifyListeners();
        return false;
      }

      if (testAccessToken == null || testAccessToken.isEmpty) {
        log('❌ TEST_ACCESS_TOKEN이 .env 파일에 없습니다!');
        _errorMessage = '테스트 토큰이 설정되지 않았습니다.';
        notifyListeners();
        return false;
      }

      log("관리자 코드 검증 완료");

      // SecureStorage에 토큰 저장
      final SecureStorageRepository secureStorage = SecureStorageRepository();
      await secureStorage.saveAccessToken(testAccessToken);

      if (testRefreshToken != null && testRefreshToken.isNotEmpty) {
        await secureStorage.saveRefreshToken(testRefreshToken);
        log("Refresh Token 저장 완료");
      }

      // 사용자 정보 저장
      await _saveUserInfo(testUserName, testUserEmail);
      await _registerFcmToken();

      _loginPlatform = LoginPlatform.none;
      loginStatus = "EXISTING_ACCOUNT";

      log("✅ 테스트 로그인 성공!");
      notifyListeners();
      return true;

    } catch (e, stackTrace) {
      log("❌ 테스트 로그인 실패: $e");
      log("Stack trace: $stackTrace");
      _errorMessage = '테스트 로그인에 실패했습니다.';
      notifyListeners();
      return false;
    }
  }


  /// 로그인 성공 후 FCM 토큰을 서버에 등록
  Future<void> _registerFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await fcmService.registerFcmToken(token);
        log('[FCM] 토큰 서버 등록 완료');
      }
    } catch (e) {
      log('[FCM] 토큰 등록 실패 (로그인은 정상): $e');
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
