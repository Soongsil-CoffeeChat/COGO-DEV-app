import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class ProfileIntroViewModel extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController introController = TextEditingController();

  void onNextPressed(BuildContext context) async {
    // 제목과 자기소개 내용을 저장합니다.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileTitle', titleController.text);
    await prefs.setString('profileIntro', introController.text);

    // 다음 페이지로 이동합니다.
    context.go('/agreement/phone/name/choose/mentor_interest/mentor_club/mentor_job/mentor_info/mentor_profile/mentor_completion');
  }

  @override
  void dispose() {
    titleController.dispose();
    introController.dispose();
    super.dispose();
  }
}
