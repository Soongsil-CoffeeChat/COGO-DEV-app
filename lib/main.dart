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

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

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
        ChangeNotifierProvider(
            create: (_) => BottomNavigationViewModel(AppRouter)),
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
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
