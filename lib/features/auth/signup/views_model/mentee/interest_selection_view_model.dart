import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenteeInterestSelectionViewModel extends ChangeNotifier {
  String? selectedInterest;

  void selectInterest(BuildContext context, String interest) async {
    selectedInterest = interest;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString('MenteeselectedInterest', interest);

    if (success) {
      print('Interest saved successfully');
      // 페이지 이동
      context.go('/agreement/phone/name/choose/mentee_interest/mentee_completion');
    } else {
      print('Failed to save interest');
    }
  }
}
