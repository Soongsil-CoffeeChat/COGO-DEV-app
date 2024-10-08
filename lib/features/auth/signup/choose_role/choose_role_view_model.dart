import 'dart:developer';

import 'package:cogo/common/db/locale_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupChooseViewModel extends ChangeNotifier {
  String? selectedRole;

  void selectRole(String role, BuildContext context) async {
    log(role);
    selectedRole = role;
    notifyListeners();

    // 역할을 SharedPreferences에 저장
    await LocaleManager.instance.setStringValue('selectedRole', role);

    // 역할에 따라 라우팅
    if (role == 'mentor') {
      context.push('/agreement/mentor_interest');
      log("멘토로 이동");
    } else if (role == 'mentee') {
      context.push('/agreement/mentee_interest');
      log("멘티로 이동");
    }
  }
}
