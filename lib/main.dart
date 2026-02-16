import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
