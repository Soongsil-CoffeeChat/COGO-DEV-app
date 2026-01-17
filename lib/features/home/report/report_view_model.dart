import 'dart:developer';

import 'package:cogo/common/enums/report_reason.dart';
import 'package:cogo/data/service/report_service.dart';
import 'package:flutter/cupertino.dart';

class ReportViewModel extends ChangeNotifier {
  final ReportService _reportService = ReportService();

  final ReportReason reason;
  final int reporterId;
  final int reportedUserId;

  final TextEditingController reportController = TextEditingController();
  String _reportContent = '';
  String get reportContent => _reportContent;
  int get reportCharCount => _reportContent.length;

  ReportViewModel({required this.reporterId, required this.reportedUserId, required this.reason}) {
    reportController.addListener(() {
      _reportContent = reportController.text;
      notifyListeners();
    });
  }

  // 신고하기
  Future<bool> postReport() async {
    try {
      await _reportService.postReportUser(
          reporterId,
          reportedUserId,
          reason.name,
          _reportContent
      );

      return true; // 성공
    } catch (error) {
      log('Error posting report: $error');
      return false; // 실패
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    reportController.dispose();
    super.dispose();
  }
}