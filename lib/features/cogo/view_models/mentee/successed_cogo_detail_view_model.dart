import 'package:flutter/material.dart';

class SuccessedCogoDetailViewModel extends ChangeNotifier {
  int _selectedTimeSlotIndex = -1;

  int get selectedTimeSlotIndex => _selectedTimeSlotIndex;

  void selectTimeSlot(int index) {
    _selectedTimeSlotIndex = index;
    notifyListeners();
  }
}
