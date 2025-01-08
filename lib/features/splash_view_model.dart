import 'dart:developer';

import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';


class SplashViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();

  Future<bool> autoLogin() async {
    try {
      final response = await userService.getUserInfo();
      if (response.email!.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Auto login failed: $e');
      return false;
    }
  }
}
