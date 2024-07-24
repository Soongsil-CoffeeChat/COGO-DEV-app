import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    selectedInterst = prefs.getString('selectedInterest');
    selectedClub = prefs.getString('selectedClub');
    selectedJob = prefs.getString('selectedJob');
    selectedExperience = prefs.getString('selectedExperience');
    selectedChurch = prefs.getString('selectedChurch');
    notifyListeners();
  }

  void selectInfo(String info) {
    selectedClub = info;
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    context.go('/agreement/phone/name/choose/mentor_interest/mentor_club/mentor_job/mentor_info/mentor_profile');
  }
}
