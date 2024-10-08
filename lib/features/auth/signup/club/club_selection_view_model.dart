import 'package:cogo/common/db/locale_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClubSelectionViewModel extends ChangeNotifier {
  String? selectedClub;

  void selectClub(BuildContext context, String club) async {
    selectedClub = club;
    notifyListeners();

    await LocaleManager.instance.setStringValue('selectedClub', club);

    // 페이지 이동
    context.push('/agreement/mentor_info');
  }
}