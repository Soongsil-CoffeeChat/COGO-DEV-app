import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class SplashViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  final UserService userService = GetIt.instance<UserService>();
  String? _navigationPath; // 네비게이션 경로
  String? get navigationPath => _navigationPath;

  Future<void> autoLogin() async {
    try {
      final accessToken = await _secureStorage.readAccessToken();

      if (accessToken != null) {
        // userService

        // if (response.statusCode == 200) {
        //   // 토큰 유효 → 홈 화면으로 이동
        //   _navigationPath = '/home';
        //   return;
        // }
      }
    } catch (e) {
      debugPrint('Auto login failed: $e');
    }

    // 토큰이 없거나 유효하지 않음 → 로그인 화면으로 이동
    _navigationPath = ' /login';
  }
}
