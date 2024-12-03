import 'package:cogo/features/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // ViewModel 초기화 및 로직 실행
    final splashViewModel = GetIt.instance<SplashViewModel>(); // getIt 사용

    // autoLogin 결과에 따라 화면 전환
    splashViewModel.autoLogin().then((isLoggedIn) {
      Future.delayed(const Duration(seconds: 2), () {
        if (isLoggedIn) {
          splashViewModel.navigateToHomeScreen(context); // 홈 화면으로 이동
        } else {
          splashViewModel.navigateToLoginScreen(context); // 로그인 화면으로 이동
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          "assets/lottie/intro.json", // Path to your Lottie file
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
