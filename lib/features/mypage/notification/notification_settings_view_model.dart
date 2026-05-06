import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:cogo/data/service/fcm_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsViewModel extends ChangeNotifier {
  static const _prefKey = 'notification_enabled';

  final FcmService fcmService = GetIt.instance<FcmService>();

  bool _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;

  NotificationSettingsViewModel() {
    _loadNotificationStatus();
  }

  Future<void> _loadNotificationStatus() async {
    if (kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_prefKey);

    // OS 권한이 거부된 경우 저장값과 무관하게 OFF
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    final osGranted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional;

    if (!osGranted) {
      _isNotificationEnabled = false;
      await prefs.setBool(_prefKey, false);
    } else {
      // 저장된 값이 없으면(첫 실행) ON으로 간주하고 토큰 등록
      _isNotificationEnabled = saved ?? true;
      if (saved == null) {
        await _registerFcmToken();
        await prefs.setBool(_prefKey, true);
      }
    }

    notifyListeners();
  }

  Future<void> setNotificationEnabled(bool value) async {
    if (kIsWeb) return;

    if (value) {
      final settings =
          await FirebaseMessaging.instance.getNotificationSettings();

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
        return;
      }

      if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
        final newSettings =
            await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
        if (newSettings.authorizationStatus != AuthorizationStatus.authorized &&
            newSettings.authorizationStatus != AuthorizationStatus.provisional) {
          return;
        }
      }

      await _registerFcmToken();
      _isNotificationEnabled = true;
      await _saveNotificationEnabled(true);
    } else {
      await _unregisterFcmToken();
      _isNotificationEnabled = false;
      await _saveNotificationEnabled(false);
    }
    notifyListeners();
  }

  Future<void> _saveNotificationEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, value);
  }

  Future<void> refreshNotificationStatus() async {
    await _loadNotificationStatus();
  }

  Future<void> _registerFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await fcmService.registerFcmToken(token);
        log('[FCM] 알림 설정 - 토큰 서버 등록 완료');
      }
    } catch (e) {
      log('[FCM] 토큰 재등록 실패: $e');
    }
  }

  Future<void> _unregisterFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        try {
          await fcmService.deleteFcmToken(token);
        } catch (e) {
          log('[FCM] 서버 토큰 삭제 실패: $e');
        }
      }
      await FirebaseMessaging.instance.deleteToken();
      log('[FCM] 알림 설정 - 토큰 삭제 완료');
    } catch (e) {
      log('[FCM] 토큰 삭제 실패: $e');
    }
  }
}
