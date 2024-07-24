import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupChooseViewModel extends ChangeNotifier {
  String? selectedRole;

  void selectRole(String role, BuildContext context) {
    selectedRole = role;
    notifyListeners();
    // 역할에 따라 라우팅
    if (role == '멘토') {
      context.go('/agreement/phone/name/choose/mentor_interest');
    } else if (role == '멘티') {
      context.go('/mentee');
    }
  }
}
