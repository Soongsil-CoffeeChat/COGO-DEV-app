import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class JobExperienceViewModel extends ChangeNotifier {
  final TextEditingController positionController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  void onNextPressed(BuildContext context) async {
    String position = positionController.text;
    String experience = experienceController.text;

    // SharedPreferences 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedJob', position);
    await prefs.setString('selectedExperience', experience);

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
