import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/common/db/locale_manager.dart';

class JobExperienceViewModel extends ChangeNotifier {
  final TextEditingController positionController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  void onNextPressed(BuildContext context) async {
    String position = positionController.text;
    String experience = experienceController.text;

    await LocaleManager.instance.setStringValue('selectedJob', position);
    await LocaleManager.instance.setStringValue('selectedExperience', experience);

    // Navigate to the next page
    context.go('/agreement/phone/name/choose/mentor_interest/mentor_club/mentor_job/mentor_info');
  }

  @override
  void dispose() {
    positionController.dispose();
    experienceController.dispose();
    super.dispose();
  }
}
