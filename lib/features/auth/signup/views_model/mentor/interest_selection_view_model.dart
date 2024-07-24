import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterestSelectionViewModel extends ChangeNotifier {
  String? selectedInterest;

  void selectInterest(BuildContext context, String interest) async {
    selectedInterest = interest;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString('selectedInterest', interest);

    if (success) {
      print('Interest saved successfully');
      // 페이지 이동
      context.go('/agreement/phone/name/choose/mentor_interest/mentor_club');
    } else {
      print('Failed to save interest');
    }
  }
}
