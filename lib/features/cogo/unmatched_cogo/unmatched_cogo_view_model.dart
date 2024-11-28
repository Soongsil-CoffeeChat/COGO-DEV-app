import 'dart:developer';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/application_service.dart';
import 'package:cogo/domain/entity/cogo_info_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UnMatchedCogoViewModel extends ChangeNotifier {
  final ApplicationService _applicationService = ApplicationService();
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  List<CogoInfoEntity> _items = [];
  bool _isLoading = false;
  String? _role;

  List<CogoInfoEntity> get items => _items;
  bool get isLoading => _isLoading;
  String? get role => _role;

  Future<void> getRole() async {
    try {
      _role = await _secureStorage.readRole();
      notifyListeners();
    } catch (e) {
      log('Error fetching role: $e');
    }
  }

  Future<void> fetchReceivedCogos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _applicationService.getRequestedCogo('UNMATCHED');
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

  Future<void> onCogoItemTapped(
      BuildContext context, CogoInfoEntity item) async {
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
