import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // If using GoRouter for navigation
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

    // Delay for a few seconds while the Lottie animation plays
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the next screen (e.g., Login Screen or Home Screen)
      context.go('/login'); // Use your navigation method here
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
