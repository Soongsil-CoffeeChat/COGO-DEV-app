import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/common/db/locale_manager.dart';

class MenteeInterestSelectionViewModel extends ChangeNotifier {
  String? selectedInterest;

  void selectInterest(BuildContext context, String interest) async {
    selectedInterest = interest;
    notifyListeners();

    await LocaleManager.instance.setStringValue('menteeSelectedInterest', interest);

    context.go('/agreement/phone/name/choose/mentee_interest/mentee_completion');
  }
}
