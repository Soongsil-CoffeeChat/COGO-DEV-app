import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'common/navigator/view_model/bottom_navigation_bar_view_model.dart';
import 'package:cogo/route/routes.dart';
import 'common/db/locale_manager.dart';
import 'package:cogo/features/home/home/view_model/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.preferencesInit();  // SharedPreferences 초기화
  await initializeDateFormatting('ko_KR', null);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
          value: BottomNavigationViewModel(AppRouter)),
      // Home에서 initState()에 provider를 상위로 두기 위함
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
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
