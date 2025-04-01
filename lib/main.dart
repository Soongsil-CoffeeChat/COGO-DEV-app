import 'package:cogo/common/navigator/bottom_navigation_bar_view_model.dart';
import 'package:cogo/data/di/get_it_locator.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:cogo/features/splash_view_model.dart';
import 'package:cogo/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  await FlutterConfig.loadEnvVariables(); // env
  await initializeDateFormatting('ko_KR', null);

  setupServiceLocator(); //get it

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => BottomNavigationViewModel(AppRouter),
      ),
      ChangeNotifierProvider(create: (_) => SplashViewModel()),
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ],
    child: MyApp(),
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
