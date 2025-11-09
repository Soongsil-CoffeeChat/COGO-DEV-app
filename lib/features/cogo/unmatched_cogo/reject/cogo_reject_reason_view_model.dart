import 'dart:developer';

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

  // 텍스트가 변경될 때마다 유효성 검사 수행
  void _validateForm() {
    isFormValid = rejectReasonController.text.isNotEmpty;
    notifyListeners();
  }

  Future<void> rejectWithReason(
      BuildContext context, int applicationId, String reason) async {
    notifyListeners();
    String reject = 'reject';
    try {
      await _applicationService.patchCogoDecision(applicationId, reject);
    } catch (e) {
      log('Error patch COGO decision: $e');
    } finally {
      notifyListeners();
    }

    Navigator.pop(context, 'refresh');
  }
}
