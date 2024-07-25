import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/common/db/locale_manager.dart';

class ProfileIntroViewModel extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController introController = TextEditingController();

  void onNextPressed(BuildContext context) async {
    await LocaleManager.instance.setStringValue('profileTitle', titleController.text);
    await LocaleManager.instance.setStringValue('profileIntro', introController.text);

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
