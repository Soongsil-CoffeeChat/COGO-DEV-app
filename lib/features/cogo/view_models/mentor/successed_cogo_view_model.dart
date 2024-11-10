import 'dart:developer';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/service/application_service.dart';
import 'package:cogo/domain/entity/requested_cogo_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessedCogoViewModel extends ChangeNotifier {
  final ApplicationService _applicationService = ApplicationService();

  List<RequestedCogoEntity> _items = [];
  bool _isLoading = false;

  List<RequestedCogoEntity> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> fetchSuccessedCogos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _applicationService.getRequestedCogo('MATCHED');
      _items = response
          .map((responseItem) => RequestedCogoEntity.fromResponse(responseItem))
          .toList();
    } catch (e) {
      log('Error fetching received cogos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onCogoItemTapped(BuildContext context, RequestedCogoEntity item) {
    context.push(
      Paths.receivedCogoDetail,
      extra: {
        'applicationId': item.applicationId,
        'menteeName': item.menteeName,
        'applicationMemo': item.applicationMemo,
        'applicationDate': item.applicationDate.toIso8601String(),
        'formattedTimeSlot': item.formattedTimeSlot,
      },
    );
  }
}
