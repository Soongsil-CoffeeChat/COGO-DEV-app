import 'package:cogo/common/db/locale_manager.dart';
import 'package:cogo/common/enums/role.dart';
import 'package:cogo/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupChooseViewModel extends ChangeNotifier {
  Role? selectedRole;

  void selectRole(Role role, BuildContext context) async {
    selectedRole = role;
    notifyListeners();

    // 역할을 SharedPreferences에 저장
    await LocaleManager.instance
        .setStringValue('selectedRole', role.toString());

    context.push("${Paths.agreement}/${Paths.interest}");
  }
}
