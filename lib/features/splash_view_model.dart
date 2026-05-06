import 'dart:developer';

import 'package:cogo/data/service/fcm_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashViewModel extends ChangeNotifier {
  static const _notificationPrefKey = 'notification_enabled';

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
      // 사용자가 알림을 꺼둔 경우 재등록하지 않음
      final prefs = await SharedPreferences.getInstance();
      final notificationEnabled = prefs.getBool(_notificationPrefKey) ?? true;
      if (!notificationEnabled) {
        log('[FCM] 알림 설정 OFF - 토큰 등록 생략');
        return;
      }

      final settings =
          await FirebaseMessaging.instance.getNotificationSettings();
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        log('[FCM] 알림 권한 없음 - 토큰 등록 생략');
        await prefs.setBool(_notificationPrefKey, false);
        return;
      }
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
