import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/common/db/locale_manager.dart';

class MentorCompletionViewModel extends ChangeNotifier {
  String? name;
  bool isLoading = true;

  MentorCompletionViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    name = LocaleManager.instance.getStringValue('name') ?? '멘토';
    isLoading = false;
    notifyListeners();
  }

  void completeApplication(BuildContext context) {
    context.go('/home'); // 다음 페이지 경로로 변경
  }
}
