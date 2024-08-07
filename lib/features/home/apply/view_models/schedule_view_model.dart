import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/constants/paths.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleViewModel extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  int selectedTimeSlot = -1;

  void onDateSelected(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void onTimeSlotSelected(int index) {
    selectedTimeSlot = index;
    notifyListeners();
  }

  Future<void> saveSelection(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedDate', selectedDate.toIso8601String());
    await prefs.setInt('selectedTimeSlot', selectedTimeSlot);

    context.push(Paths.memo);
  }
}
