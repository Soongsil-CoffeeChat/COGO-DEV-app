import 'package:cogo/common/enums/login_platform.dart';
import 'package:cogo/common/enums/account_status.dart';
import 'package:cogo/constants/paths.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                            AccountStatus.NEW_ACCOUNT.name) {
                          context.push(Paths.agreement);
                        } else if (viewModel.loginStatus ==
                            AccountStatus.EXISTING_ACCOUNT.name ||
                            viewModel.loginStatus ==
                                AccountStatus.RESTORED_ACCOUNT.name) {
                          context.push(Paths.home);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 15),

                  /// 애플 로그인 버튼: Android에서는 숨김, 웹은 기본적으로 숨김
                  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS)
                    SizedBox(
                      child: _loginButton(
                        platform: LoginPlatform.apple,
                        onTap: () async {
                          await viewModel.signInWithApple();
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

                  const SizedBox(height: 30),

                  /// 관리자용 로그인 버튼
                  TextButton(
                    onPressed: () {
                      _showAdminCodeDialog(context, viewModel);
                    },
                    child: const Text(
                      '관리자용 로그인',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
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

  /// 관리자 코드 입력 다이얼로그
  void _showAdminCodeDialog(BuildContext context, LoginViewModel viewModel) {
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('관리자 인증'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '관리자 코드를 입력하세요',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: codeController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '코드',
                  hintText: '관리자 코드 입력',
                ),
                autofocus: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () async {
                final code = codeController.text.trim();

                if (code.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('코드를 입력해주세요')),
                  );
                  return;
                }

                // 다이얼로그 닫기
                Navigator.of(dialogContext).pop();

                // 코드 검증 및 로그인
                final isValid = await viewModel.signInTest(code);

                if (isValid) {
                  // 로그인 성공 시 홈으로 이동
                  if (context.mounted) {
                    context.push(Paths.home);
                  }
                } else {
                  // 로그인 실패 시 에러 메시지
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('잘못된 관리자 코드입니다')),
                    );
                  }
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
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
          return 'assets/image/img_apple_login.svg';
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