import 'package:cogo/data/service/refresh_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/enums/login_platform.dart';
import 'login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // PhoneNumberVerificationViewModel에 UserRepositoryImpl 주입
      create: (_) => LoginViewModel(
        refreshService:
            RefreshService(), // UserService 인스턴스 생성 후 UserRepositoryImpl에 주입
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Consumer<LoginViewModel>(builder: (context, viewModel, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: _loginButton(
                      'google_logo',
                      () async {
                        await viewModel.signInWithGoogle();
                        if (viewModel.loginPlatform == LoginPlatform.google) {
                          context.push('/agreement');
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
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
