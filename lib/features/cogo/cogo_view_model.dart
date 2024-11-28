import 'dart:developer';

import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CogoViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  String? _role;
  String? get role => _role;

  Future<void> getRole() async {
    try {
      _role = await _secureStorage.readRole();
      notifyListeners();
    } catch (e) {
      log('Error fetching role: $e');
    }
  }

  void navigateToReceivedCogo(BuildContext context) {
    context.push(Paths.unMatchedCogo);
  }

  void navigateToSuccessedCogo(BuildContext context) {
    context.push(Paths.matchedCogo);
  }
}
