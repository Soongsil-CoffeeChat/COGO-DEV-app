import 'dart:developer';

import 'package:cogo/data/service/application_service.dart';
import 'package:cogo/domain/entity/requested_cogo_entity.dart';
import 'package:flutter/material.dart';

class UnMatchedCogoDetailViewModel extends ChangeNotifier {
  final ApplicationService _applicationService = ApplicationService();

  RequestedCogoEntity? _item;
  bool _isLoading = false;
  int? _selectedTimeSlotIndex;

  RequestedCogoEntity? get item => _item;

  bool get isLoading => _isLoading;

  int? get selectedTimeSlotIndex => _selectedTimeSlotIndex;

  Future<void> fetchCogoDetail(int applicationId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _applicationService.getCogoDetail(applicationId);
      _item = RequestedCogoEntity.fromResponse(response);
    } catch (e) {
      log('Error fetching COGO detail: $e');
      _item = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectTimeSlot(int index) {
    _selectedTimeSlotIndex = index;
    notifyListeners();
  }

  Future<void> accept(BuildContext context, int applicationId) async {
    _isLoading = true;
    notifyListeners();
    String accept = 'accept';

    try {
      await _applicationService.patchCogoDecision(applicationId, accept);
    } catch (e) {
      log('Error patch COGO decision: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    Navigator.pop(context, 'refresh');
  }

  Future<void> reject(BuildContext context, int applicationId) async {
    _isLoading = true;
    notifyListeners();
    String reject = 'reject';
    try {
      await _applicationService.patchCogoDecision(applicationId, reject);
    } catch (e) {
      log('Error patch COGO decision: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    Navigator.pop(context, 'refresh');
  }
}
