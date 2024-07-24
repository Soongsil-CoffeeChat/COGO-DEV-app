import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletionViewModel extends ChangeNotifier {
  String? name;

  CompletionViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '멘토';
    notifyListeners();
  }

  void completeApplication(BuildContext context) {
    context.go('/home'); // 다음 페이지 경로로 변경
  }
}
