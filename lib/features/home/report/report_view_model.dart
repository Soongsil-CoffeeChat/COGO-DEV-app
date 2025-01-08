import 'package:flutter/cupertino.dart';

class ReportViewModel extends ChangeNotifier {
  final TextEditingController reportController = TextEditingController();

  int get reportCharCount => reportController.text.length;

  ReportViewModel() {
    reportController.addListener(() {
      notifyListeners();
    });
  }

  bool postReport() {
    return true;
  }
}
