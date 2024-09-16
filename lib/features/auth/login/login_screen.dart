import 'dart:developer';

import 'package:cogo/common/enums/login_platform.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      log('name = ${googleUser.displayName}');
      log('email = ${googleUser.email}');
      log('id = ${googleUser.id}');

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      log("hashCode 토큰: ${googleUser.serverAuthCode.hashCode}");
      log("토큰: ${googleSignInAuthentication.accessToken}");

      // 로컬 저장소에 사용자 정보 저장
      await _saveUserInfo(googleUser.displayName, googleUser.email);

      // 로그인 성공 시 상태 업데이트
      setState(() {
        _loginPlatform = LoginPlatform.google;
      });

      context.push('/agreement');
    }
  }

  Future<void> _saveUserInfo(String? name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name ?? '');
    await prefs.setString('user_email', email);
  }

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
                children: [
            const SizedBox(width: 16),
            Expanded(
                    child: _loginButton(
                      'google_logo',
                      signInWithGoogle,
                    ),
                  ),

                ],
              ),
      ),
    );
  }

  Widget _loginButton(String path, VoidCallback onTap) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: double.infinity, // 부모의 너비를 꽉 채움
            child: Image.asset(
              "assets/image/button_google_login.png",
              fit: BoxFit.fitWidth, // 이미지가 너비에 맞춰 비율 유지하며 크기 조절
            ),
          ),
        ),
      );
}
