import 'package:flutter/material.dart';

class AgreementViewModel extends ChangeNotifier {
  List<bool> _isChecked = [false, false, false, false, false];

  List<bool> get isChecked => _isChecked;

  void updateCheckState(int index, bool value) {
    _isChecked[index] = value;
    notifyListeners();
  }

  bool get isAllRequiredChecked {
    return _isChecked[0] && _isChecked[1] && _isChecked[2] && _isChecked[3];
  }
}
