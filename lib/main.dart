import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:cogo/common/navigator/bottom_navigation_bar_view_model.dart';
import 'package:cogo/data/di/get_it_locator.dart';
import 'package:cogo/features/chat/chat_view_model.dart';
import 'package:cogo/features/cogo/cogo_view_model.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:cogo/features/mypage/mypage_view_model.dart';
import 'package:cogo/features/splash_view_model.dart';
import 'package:cogo/firebase_options.dart';
import 'package:cogo/route/routes.dart';

// 현재 열려있는 채팅방 ID (null이면 채팅방에 없는 상태)
int? activeChatRoomId;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _channel = AndroidNotificationChannel(
  'cogo_notification',
  'COGO 알림',
  description: 'COGO 앱 푸시 알림',
  importance: Importance.high,
);

const NotificationDetails _notificationDetails = NotificationDetails(
  android: AndroidNotificationDetails(
    'cogo_notification',
    'COGO 알림',
    channelDescription: 'COGO 앱 푸시 알림',
    icon: '@drawable/ic_notification',
    color: Color(0xFF000000),
    importance: Importance.high,
    priority: Priority.high,
  ),
  iOS: DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  ),
);

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) print('[FCM] 백그라운드 메시지: ${message.messageId}');
}

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _setupFCM();

  if (!kIsWeb) {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await dotenv.load(fileName: '.env');
  }

  await initializeDateFormatting('ko_KR', null);
  setupServiceLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CogoViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => MypageViewModel()),
        ChangeNotifierProvider(create: (_) => BottomNavigationViewModel(AppRouter)),
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
      ],
      child: const MyApp(),
    ),
  );

  if (!kIsWeb) FlutterNativeSplash.remove();
}

Future<void> _setupFCM() async {
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  if (kDebugMode) print('[FCM] 권한 상태: ${settings.authorizationStatus}');

  await flutterLocalNotificationsPlugin.initialize(
    settings: const InitializationSettings(
      android: AndroidInitializationSettings('@drawable/ic_notification'),
      iOS: DarwinInitializationSettings(),
    ),
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);

  // iOS 포그라운드 알림 자동 표시 비활성화 → onMessage에서 flutter_local_notifications로 처리
  await messaging.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen(_onForegroundMessage);

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    if (kDebugMode) print('[FCM] 알림 탭으로 앱 열림: ${message.notification?.title}');
  });

  final granted = settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional;
  if (!granted) {
    if (kDebugMode) print('[FCM] 알림 권한 없음 - 토큰 발급 생략');
    return;
  }

  try {
    final token = await messaging.getToken();
    if (kDebugMode) print('[FCM] Token: $token');
  } catch (e) {
    if (kDebugMode) print('[FCM] 토큰 발급 실패: $e');
  }
}

void _onForegroundMessage(RemoteMessage message) {
  if (kDebugMode) {
    print('[FCM] 포그라운드 수신 | title: ${message.notification?.title} | roomId: ${message.data['roomId']} | activeChatRoomId: $activeChatRoomId');
  }

  final roomId = message.data['roomId'];
  if (activeChatRoomId != null &&
      roomId != null &&
      int.tryParse(roomId.toString()) == activeChatRoomId) {
    return;
  }

  if (kIsWeb) return;

  final notification = message.notification;
  if (notification == null) return;

  flutterLocalNotificationsPlugin.show(
    id: notification.hashCode,
    title: notification.title,
    body: notification.body,
    notificationDetails: _notificationDetails,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        if (kIsWeb) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430, minWidth: 320),
              child: child,
            ),
          );
        }
        return child!;
      },
    );
  }
}
