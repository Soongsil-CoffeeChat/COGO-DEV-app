import 'package:cogo/common/enums/report_reason.dart';
import 'package:flutter/cupertino.dart';

class ReportViewModel extends ChangeNotifier {
  final ReportReason reason;
  final TextEditingController reportController = TextEditingController();

  String _reportContent = '';

  String get reportContent => _reportContent;

  int get reportCharCount => _reportContent.length;

  ReportViewModel({required this.reason}) {
    reportController.addListener(() {
      _reportContent = reportController.text;
      notifyListeners();
    });
  }

  // 신고하기
  Future<bool> postReport() async {
    return true;
  }

  // 4. 메모리 해제 (중요!)
  @override
  void dispose() {
    reportController.dispose();
    super.dispose();
  }
}