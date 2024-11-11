import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/locale_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompletionViewModel extends ChangeNotifier {
  String? role;
  bool isLoading = true;

  CompletionViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    role = LocaleManager.instance.getStringValue('selectedRole') ?? 'mentor';
    isLoading = false;
    notifyListeners();
  }

  void completeApplication(BuildContext context) {
    context.go(Paths.home); // 다음 페이지 경로로 변경
    //todo 자동로그인 로직
  }
}
