import 'package:cogo/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'data/di/get_it_locator.dart';
import 'data/repository/local/locale_manager.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  await FlutterConfig.loadEnvVariables(); // env
  await LocaleManager.preferencesInit();  // SharedPreferences 초기화
  await initializeDateFormatting('ko_KR', null);

  setupServiceLocator(); //get it
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter,
    );
  }
}
