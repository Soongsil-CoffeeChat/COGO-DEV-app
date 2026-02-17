import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:cogo/common/navigator/bottom_navigation_bar_view_model.dart';
import 'package:cogo/data/di/get_it_locator.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:cogo/features/splash_view_model.dart';
import 'package:cogo/route/routes.dart';

import 'features/chat/chat_view_model.dart';
import 'features/cogo/cogo_view_model.dart';
import 'features/mypage/mypage_view_model.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _setupFCM();

  // Splash는 모바일에서만
  if (!kIsWeb) {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }

  // dotenv는 웹에서 불가능
  if (!kIsWeb) {
    await dotenv.load(fileName: ".env");
  }

  await initializeDateFormatting('ko_KR', null);
  setupServiceLocator();

  runApp(
    MultiProvider(
      providers: [
        // 앱 전역에서 사용할 뷰모델들을 여기서 생성합니다.
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CogoViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => MypageViewModel()),

        ChangeNotifierProvider(
            create: (_) => BottomNavigationViewModel(AppRouter)),
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
      ],
      child: const MyApp(),
    ),
  );

  if (!kIsWeb) {
    FlutterNativeSplash.remove();
  }
}

Future<void> _setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // 알림 권한 요청 (iOS/Web 필수)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (kDebugMode) {
    print('User granted permission: ${settings.authorizationStatus}');
  }

  // 백그라운드 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 포그라운드 메시지 수신 처리
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print("==============================================");
      print("포그라운드 메시지 수신!");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
      print("Data: ${message.data}");
      print("==============================================");
    }
  });

  // 알림 탭해서 앱 열었을 때 처리
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (kDebugMode) {
      print("알림 탭으로 앱 열림: ${message.notification?.title}");
    }
  });

  // 토큰 확인 (콘솔 테스트용)
  String? token = await messaging.getToken();
  if (kDebugMode) {
    print("==============================================");
    print("FCM Token: $token");
    print("==============================================");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // 모바일 크기로 제한
        if (kIsWeb) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 430,
                minWidth: 320,
              ),
              child: child,
            ),
          );
        }
        return child!;
      },
    );
  }
}
