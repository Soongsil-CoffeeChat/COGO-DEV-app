import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:cogo/data/service/fcm_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NotificationSettingsViewModel extends ChangeNotifier {
  final FcmService fcmService = GetIt.instance<FcmService>();

  bool _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;

  NotificationSettingsViewModel() {
    _loadNotificationStatus();
  }

  Future<void> _loadNotificationStatus() async {
    if (kIsWeb) return;
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    final wasEnabled = _isNotificationEnabled;
    _isNotificationEnabled =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional;

    if (!wasEnabled && _isNotificationEnabled) {
      await _registerFcmToken();
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
    } else {
      _isNotificationEnabled = false;
    }
    notifyListeners();
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
}
