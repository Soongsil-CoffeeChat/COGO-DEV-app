import 'package:cogo/data/repository/local/locale_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MentorInfoViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  String? name;
  String? selectedInterst;
  String? selectedClub;
  String? selectedJob;
  String? selectedExperience;
  String? selectedChurch;
  bool isButtonClicked = false;

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
    isButtonClicked = true;
    notifyListeners();
    Future.delayed(Duration(milliseconds: 300), () {
      context.push('/agreement/completion');
    });
  }
}
