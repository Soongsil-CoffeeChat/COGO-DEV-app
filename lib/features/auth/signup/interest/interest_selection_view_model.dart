import 'package:cogo/common/db/locale_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InterestSelectionViewModel extends ChangeNotifier {
  String? selectedInterest;

  void selectInterest(BuildContext context, String interest) async {
    selectedInterest = interest;
    notifyListeners();

    await LocaleManager.instance.setStringValue('SelectedInterest', interest);

    context.push('/agreement/mentor_club');

    // context.push('/agreement/completion');
//todo
  }
}
