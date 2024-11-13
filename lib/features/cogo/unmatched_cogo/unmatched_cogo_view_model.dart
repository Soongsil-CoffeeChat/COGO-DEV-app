import 'dart:developer';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/service/application_service.dart';
import 'package:cogo/domain/entity/requested_cogo_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UnMatchedCogoViewModel extends ChangeNotifier {
  final ApplicationService _applicationService = ApplicationService();

  List<RequestedCogoEntity> _items = [];
  bool _isLoading = false;

  List<RequestedCogoEntity> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> fetchReceivedCogos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _applicationService.getRequestedCogo('UNMATCHED');
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

  Future<void> onCogoItemTapped(
      BuildContext context, RequestedCogoEntity item) async {
    final result = await GoRouter.of(context).push(
      Paths.unMatchedCogoDetail,
      extra: {'applicationId': item.applicationId},
    );

    if (result == 'refresh') {
      Provider.of<UnMatchedCogoViewModel>(context, listen: false)
          .fetchReceivedCogos();
    }
  }
}
