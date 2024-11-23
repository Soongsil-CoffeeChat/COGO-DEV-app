import 'dart:developer';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/service/application_service.dart';
import 'package:cogo/domain/entity/cogo_info_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchedCogoViewModel extends ChangeNotifier {
  final ApplicationService _applicationService = ApplicationService();

  List<CogoInfoEntity> _items = [];
  bool _isLoading = false;

  List<CogoInfoEntity> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> fetchSuccessedCogos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _applicationService.getRequestedCogo('MATCHED');
      _items = response
          .map((responseItem) => CogoInfoEntity.fromResponse(responseItem))
          .toList();
    } catch (e) {
      log('Error fetching received cogos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onCogoItemTapped(BuildContext context, CogoInfoEntity item) {
    context.push(
      Paths.matchedCogoDetail,
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
