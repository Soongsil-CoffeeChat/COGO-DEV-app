import 'dart:developer';

import 'package:cogo/data/service/fcm_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';


class SplashViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();
  final FcmService fcmService = GetIt.instance<FcmService>();

  Future<bool> autoLogin() async {
    try {
      final response = await userService.getUserInfo();
      if (response.email!.isNotEmpty) {
        await _registerFcmToken();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Auto login failed: $e');
      return false;
    }
  }

  Future<void> _registerFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await fcmService.registerFcmToken(token);
        log('[FCM] 자동로그인 - 토큰 서버 등록 완료');
      }
    } catch (e) {
      log('[FCM] 토큰 등록 실패 (자동로그인은 정상): $e');
    }
  }
}
