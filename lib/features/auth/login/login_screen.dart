import 'package:cogo/common/enums/login_platform.dart';
import 'package:cogo/common/enums/account_status.dart';
import 'package:cogo/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import 'login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Consumer<LoginViewModel>(builder: (context, viewModel, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (viewModel.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(viewModel.errorMessage!),
                      action: SnackBarAction(
                        label: 'Retry',
                        onPressed: () {
                          viewModel.clearError();
                          viewModel.signInWithGoogle();
                        },
                      ),
                    ),
                  );
                }
              });

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/cogo_logo.svg',
                    width: 120,
                  ),
                  const SizedBox(height: 200),
                  SizedBox(
                    child: _loginButton(
                      platform: LoginPlatform.google,
                      onTap: () async {
                        await viewModel.signInWithGoogle();
                        if (viewModel.loginStatus ==
                                AccountStatus.NEW_ACCOUNT.name ||
                            viewModel.loginStatus ==
                                AccountStatus.RESTORED_ACCOUNT.name) {
                          context.push(Paths.agreement);
                        } else {
                          context.push(Paths.home);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 15),

                  /// ✅ 애플 로그인 버튼: Android에서는 숨김
                  if (!Platform.isAndroid)
                    SizedBox(
                      child: _loginButton(
                        platform: LoginPlatform.apple,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('애플 로그인은 준비 중입니다.'),
                            ),
                          );
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

  Widget _loginButton({
    required LoginPlatform platform,
    required VoidCallback onTap,
  }) {
    String getPlatformAsset(LoginPlatform platform) {
      switch (platform) {
        case LoginPlatform.google:
          return 'assets/image/img_google_login.svg';
        case LoginPlatform.apple:
          return 'assets/image/img_apple_login.svg'; //todo 일단 구글로
        default:
          return '';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(
            getPlatformAsset(platform),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
