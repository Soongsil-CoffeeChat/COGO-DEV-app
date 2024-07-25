import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/common/db/locale_manager.dart';

class MenteeCompletionViewModel extends ChangeNotifier {
  String? name;

  CompletionViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    name = LocaleManager.instance.getStringValue('name') ?? '멘토';
    notifyListeners();
  }

  void completeApplication(BuildContext context) {
    context.go('/home'); // 다음 페이지 경로로 변경
  }
}
