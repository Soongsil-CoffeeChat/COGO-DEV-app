import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/enums/login_platform.dart';
import 'login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: _loginButton(
                'google_logo',
                () async {
                  await loginViewModel.signInWithGoogle();
                  if (loginViewModel.loginPlatform == LoginPlatform.google) {
                    context.push('/agreement');
                  }
                },
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
            width: double.infinity, // 부모의 너비를 꽉 채
            // 움
            child: Image.asset(
              "assets/image/button_google_login.png",
              fit: BoxFit.fitWidth, // 이미지가 너비에 맞춰 비율 유지하며 크기 조절
            ),
          ),
        ),
      );
}
