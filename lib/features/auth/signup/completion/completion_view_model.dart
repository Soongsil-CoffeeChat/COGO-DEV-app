import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompletionViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  String? role;
  bool isLoading = true;

  CompletionViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    role = await _secureStorage.readRole();
    isLoading = false;
    notifyListeners();
  }
}
