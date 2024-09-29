import 'dart:developer';

import 'package:cogo/common/enums/login_platform.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  LoginPlatform get loginPlatform => _loginPlatform;

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      log('name = ${googleUser.displayName}');
      log('email = ${googleUser.email}');
      log('id = ${googleUser.id}');

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      log("hashCode 토큰: ${googleUser.serverAuthCode.hashCode}");
      log("토큰: ${googleSignInAuthentication.accessToken}");

      await _saveUserInfo(googleUser.displayName, googleUser.email);

      _loginPlatform = LoginPlatform.google;
      notifyListeners();
    }
  }

  Future<void> _saveUserInfo(String? name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name ?? '');
    await prefs.setString('user_email', email);
  }

  Future<void> signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
    }

    _loginPlatform = LoginPlatform.none;
    notifyListeners();
  }
}
