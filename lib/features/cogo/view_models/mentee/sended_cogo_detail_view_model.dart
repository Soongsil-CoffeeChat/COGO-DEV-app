import 'package:flutter/material.dart';

class SendedCogoDetailViewModel extends ChangeNotifier {
  int _selectedTimeSlotIndex = -1;
  bool _isAcceptSelected = false;

  int get selectedTimeSlotIndex => _selectedTimeSlotIndex;
  bool get isAcceptSelected => _isAcceptSelected;

  void selectTimeSlot(int index) {
    _selectedTimeSlotIndex = index;
    _isAcceptSelected = true;
    notifyListeners();
  }
}
