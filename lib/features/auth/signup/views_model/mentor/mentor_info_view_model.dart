import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/common/db/locale_manager.dart';

class MentorInfoViewModel extends ChangeNotifier {
  String? name;
  String? selectedInterst;
  String? selectedClub;
  String? selectedJob;
  String? selectedExperience;
  String? selectedChurch;

  MentorInfoViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    notifyListeners();

    name = LocaleManager.instance.getStringValue('name');
    selectedInterst = LocaleManager.instance.getStringValue('mentorSelectedInterest');
    selectedClub = LocaleManager.instance.getStringValue('selectedClub');
    selectedJob = LocaleManager.instance.getStringValue('selectedJob');
    selectedExperience = LocaleManager.instance.getStringValue('selectedExperience');
    selectedChurch = LocaleManager.instance.getStringValue('selectedChurch');
  }

  void selectInfo(String info) {
    selectedClub = info;
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    context.push('/agreement/mentor_completion');
  }
}
