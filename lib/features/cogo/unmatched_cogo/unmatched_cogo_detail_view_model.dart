import 'dart:developer';

import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/application_service.dart';
import 'package:cogo/data/service/chat_service.dart';
import 'package:cogo/domain/entity/cogo_detail_entity.dart';
import 'package:cogo/domain/entity/cogo_info_entity.dart';
import 'package:cogo/features/cogo/unmatched_cogo/reject/cogo_reject_reason_view_model.dart';
import 'package:cogo/features/cogo/unmatched_cogo/unmatched_cogo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UnMatchedCogoDetailViewModel extends ChangeNotifier {
  final ApplicationService _applicationService = ApplicationService();
  final ChatService _chatService = ChatService();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  CogoDetailEntity? _item;
  bool _isLoading = false;
  int? _selectedTimeSlotIndex;
  String? _role;

  CogoDetailEntity? get item => _item;

  bool get isLoading => _isLoading;

  int? get selectedTimeSlotIndex => _selectedTimeSlotIndex;
  String? get role => _role;

  int id = 0;

  UnMatchedCogoDetailViewModel() {
    getRole();
  }

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
      id = response.menteeId;
      _item = CogoDetailEntity.fromResponse(response);
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

    try {
      await _chatService.postChattingRoom(id);
    } catch (e) {
      log('Error creative catting room: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reject(BuildContext context, int applicationId) async {
    final result = await GoRouter.of(context).push(
      Paths.cogoReject,
      extra: {
        'applicationId': applicationId,
      },
    );
  }
}
