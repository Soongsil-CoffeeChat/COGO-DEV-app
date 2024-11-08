import 'dart:developer';

import 'package:cogo/data/service/application_service.dart';
import 'package:flutter/material.dart';
import 'package:cogo/constants/paths.dart';
import 'package:go_router/go_router.dart';

class MatchingViewModel extends ChangeNotifier {
  final ApplicationService _applicationService = ApplicationService();

  Future<void> completeApplication(BuildContext context, int mentorId,
      int possibleDateId, String memo) async {
    try {
      final response = await _applicationService.postCogo(
        mentorId,
        possibleDateId,
        memo,
      );

      log("Cogo 신청 성공: ${response.toString()}");
      context.go(Paths.home);
    } on Exception catch (e) {
      log("Cogo 신청 실패: $e");
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
