import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cogo/common/enums/login_platform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      print("hashCode 토큰: ${googleUser.serverAuthCode.hashCode}");
      print("토큰: ${googleSignInAuthentication.accessToken}");

      // 로그인 성공 시 상태 업데이트
      setState(() {
        _loginPlatform = LoginPlatform.google;
      });
    }
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
        child: _loginPlatform != LoginPlatform.none
            ? _logoutButton()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(width: 16),  // 두 항목 사이에 여백을 줄 수 있습니다
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

  Widget _logoutButton() {
    return ElevatedButton(
      onPressed: signOut,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff0165E1),
        ),
      ),
      child: const Text('로그아웃'),
    );
  }
}
