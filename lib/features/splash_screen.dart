import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<String> _images = [
    'assets/image/img_splash1.png',
    'assets/image/img_splash2.png',
    'assets/image/img_splash3.png',
    'assets/image/img_splash4.png',
  ];

  int _currentIndex = 0; // Current image index
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        if (_currentIndex < _images.length - 1) {
          _currentIndex++;
        } else {
          _timer!.cancel();
          // Navigate to the login screen after the last image
          context.push(Paths.login);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSwitcher(
      duration: const Duration(milliseconds: 500), // Animation duration
      // child: Container(
      // width: double.infinity, // Ensure full width
      // height: double.infinity, // Ensure full height
      child: Image.asset(
        _images[_currentIndex],
        key: ValueKey<int>(_currentIndex), // Unique key for each image
        fit: BoxFit.cover, // Ensure the image covers the entire container
        // ),
      ),
    ));
  }
}
