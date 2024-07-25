import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/navigator/view_model/bottom_navigation_bar_view_model.dart';
import 'package:cogo/route/routes.dart';
import 'common/db/locale_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.preferencesInit();  // SharedPreferences 초기화
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
