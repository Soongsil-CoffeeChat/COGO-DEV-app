import 'package:flutter/material.dart';

class ReceivedCogoDetailViewModel extends ChangeNotifier {
  int _selectedTimeSlotIndex = -1; // 선택된 시간대 버튼의 인덱스
  bool _isAcceptSelected = false; // 수락 버튼의 선택 상태

  int get selectedTimeSlotIndex => _selectedTimeSlotIndex;
  bool get isAcceptSelected => _isAcceptSelected;

  void selectTimeSlot(int index) {
    _selectedTimeSlotIndex = index;
    _isAcceptSelected = true;
    notifyListeners();
  }

  void accept(BuildContext context) {
    _isAcceptSelected = true;
    notifyListeners();
    Navigator.of(context).pop();
  }

  void reject(BuildContext context) {
    Navigator.of(context).pop();
  }
}
