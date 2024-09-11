import 'package:cogo/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'common/db/locale_manager.dart';
import 'common/navigator/view_model/bottom_navigation_bar_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables(); // env
  await LocaleManager.preferencesInit();  // SharedPreferences 초기화
  await initializeDateFormatting('ko_KR', null);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
          value: BottomNavigationViewModel(AppRouter)),
    ],
    child: const MyApp(),
  ));
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
