import 'package:flutter/material.dart';

class MatchedCogoDetailViewModel extends ChangeNotifier {
  int _selectedTimeSlotIndex = -1;

  int get selectedTimeSlotIndex => _selectedTimeSlotIndex;

  void selectTimeSlot(int index) {
    _selectedTimeSlotIndex = index;
    notifyListeners();
  }

  bool isTimeSlotSelected(int index) {
    return index == _selectedTimeSlotIndex;
  }
}
