import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/common/db/locale_manager.dart';

class SignupChooseViewModel extends ChangeNotifier {
  String? selectedRole;

  void selectRole(String role, BuildContext context) async {
    selectedRole = role;
    notifyListeners();

    // 역할을 SharedPreferences에 저장
    await LocaleManager.instance.setStringValue('selectedRole', role);

    // 역할에 따라 라우팅
    if (role == 'metor') {
      context.push('/agreement/mentor_interest');
    } else if (role == 'mentee') {
      context.push('/agreement/mentee_interest');
    }
  }
}
