import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClubSelectionViewModel extends ChangeNotifier {
  String? selectedClub;

  void selectClub(BuildContext context, String club) async {
    selectedClub = club;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedClub', club);

    // 페이지 이동
    context.go('/agreement/phone/name/choose/mentor_interest/mentor_club/mentor_job');
  }

  void skipSelection(BuildContext context) async {
    // SharedPreferences에서 selectedClub 값을 제거합니다.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedClub');

    // selectedClub 변수를 null로 설정합니다.
    selectedClub = null;
    notifyListeners();

    // 다음 페이지로 이동합니다.
    context.go('/agreement/phone/name/choose/mentor_interest/mentor_club/mentor_job/mentor_info');
  }
}