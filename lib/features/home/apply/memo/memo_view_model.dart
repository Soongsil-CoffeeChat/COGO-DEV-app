import 'package:flutter/material.dart';
import 'package:cogo/constants/paths.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoViewModel extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final int mentorId;
  final int possibleDateId;
  int charCount = 0;

  MemoViewModel({
    required this.mentorId,
    required this.possibleDateId,
  }) {
    controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    charCount = controller.text.length;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.removeListener(_onTextChanged);
    controller.dispose();
    super.dispose();
  }

  Future<void> saveMemo(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('memoContent', controller.text);

    final extraData = {
      'memoContent': controller.text,
      'mentorId': mentorId,
      'possibleDateId': possibleDateId,
    };

    context.push(Paths.matching, extra: extraData);
  }
}
