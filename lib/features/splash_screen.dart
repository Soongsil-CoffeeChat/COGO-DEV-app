import 'dart:developer';

import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
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

    final splashViewModel = GetIt.instance<SplashViewModel>(); // getIt 사용
    splashViewModel.autoLogin().then((isLoggedIn) {
      Future.delayed(const Duration(seconds: 2), () {
        if (isLoggedIn) {
          log("=====자동로그인 성공=====");
          context.push(Paths.home);
        } else {
          context.push(Paths.login);
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
          "assets/lottie/intro.json",
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
