import 'dart:developer';

import 'package:cogo/common/enums/application_reject_reason.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/application_service.dart';
import 'package:cogo/domain/entity/cogo_detail_entity.dart';
import 'package:cogo/domain/entity/cogo_info_entity.dart';
import 'package:flutter/material.dart';

class CogoRejectReasonViewModel extends ChangeNotifier {
  final ApplicationService _applicationService = ApplicationService();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  final TextEditingController rejectReasonController = TextEditingController();
  int get rejectReasonCount => rejectReasonController.text.length;

  bool isFormValid = false;

  CogoRejectReasonViewModel() {
    rejectReasonController.addListener(_validateForm);
  }

  void _validateForm() {
    isFormValid = rejectReasonController.text.isNotEmpty;
    notifyListeners();
  }

  Future<void> rejectWithReason(
    BuildContext context,
    int applicationId,
    String displayText,
  ) async {
    notifyListeners();

    try {
      final rejectionReason =
          ApplicationRejectReason.fromDisplayString(displayText);

      if (rejectionReason == null) {
        log('Error: Invalid rejection reason - $displayText');
        return;
      }

      await _applicationService.patchCogoDecision(
        applicationId,
        'REJECTED',
        rejectionReason.name,
      );

      log('Reject reason sent: ${rejectionReason.name}');
    } catch (e) {
      log('Error patch COGO decision: $e');
    } finally {
      notifyListeners();
    }

    Navigator.pop(context, 'refresh');
  }
}
