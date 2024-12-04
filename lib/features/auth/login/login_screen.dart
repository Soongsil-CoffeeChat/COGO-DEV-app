import 'package:cogo/common/enums/login_platform.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
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

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: _loginButton(
                      platform: LoginPlatform.google,
                      onTap: () async {
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

  Widget _loginButton({
    required LoginPlatform platform,
    required VoidCallback onTap,
  }) {
    String getPlatformAsset(LoginPlatform platform) {
      switch (platform) {
        case LoginPlatform.google:
          return 'assets/image/button_google_login.png';
        case LoginPlatform.apple:
          return 'assets/image/button_google_login.png'; //todo 일단 구글로
        default:
          return 'assets/image/button_google_login.png';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Image.asset(
            getPlatformAsset(platform),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
