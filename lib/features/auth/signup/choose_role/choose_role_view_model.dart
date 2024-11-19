import 'dart:developer';

import 'package:cogo/common/enums/role.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupChooseViewModel extends ChangeNotifier {
  // Role? selectedRole;
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  void selectRole(Role role, BuildContext context) async {
    log(role.toString());
    // selectedRole = role;
    notifyListeners();

    // 역할을 SharedPreferences에 저장
    // await LocaleManager.instance.setStringValue('selectedRole', role.toString());
    await _secureStorage.saveRole(role.name);

    // 역할에 따라 라우팅
    if (role == Role.MENTOR) {
      context.push('/agreement/interest');
      log("멘토로 이동");
    } else if (role == Role.MENTEE) {
      context.push('/agreement/interest');
      log("멘티로 이동");
    }
  }
}
