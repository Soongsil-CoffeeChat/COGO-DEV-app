import 'package:cogo/common/db/locale_manager.dart';
import 'package:cogo/common/enums/role.dart';
import 'package:cogo/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InterestSelectionViewModel extends ChangeNotifier {
  String? role;
  String? selectedInterest;

  InterestSelectionViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    role = LocaleManager.instance.getStringValue('selectedRole');
    notifyListeners();
  }

  void selectInterest(BuildContext context, String interest) async {
    selectedInterest = interest;
    notifyListeners();

    await LocaleManager.instance.setStringValue('SelectedInterest', interest);

    if (role == Role.mentor.toString()) {
      //todo
      context.push('${Paths.agreement}/${Paths.mentorClub}');
    } else if (role == Role.mentee.toString()) {
      context.push('${Paths.agreement}/${Paths.completion}');
    }
  }
}
