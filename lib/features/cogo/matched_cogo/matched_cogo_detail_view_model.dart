import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/application_service.dart';
import 'package:cogo/domain/entity/cogo_info_entity.dart';
import 'package:flutter/material.dart';

class MatchedCogoDetailViewModel extends ChangeNotifier {
  final ApplicationService _applicationService = ApplicationService();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  CogoInfoEntity? _item;
  bool _isLoading = false;
  int? _selectedTimeSlotIndex;
  String? _role;

  CogoInfoEntity? get item => _item;
  bool get isLoading => _isLoading;
  int? get selectedTimeSlotIndex => _selectedTimeSlotIndex;
  String? get role => _role;

  Future<void> getRole() async {
    try {
      _role = await _secureStorage.readRole();
      notifyListeners();
    } catch (e) {
      log('Error fetching role: $e');
    }
  }

  Future<void> fetchCogoDetail(int applicationId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _applicationService.getCogoDetail(applicationId);
      _item = CogoInfoEntity.fromResponse(response);
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
}