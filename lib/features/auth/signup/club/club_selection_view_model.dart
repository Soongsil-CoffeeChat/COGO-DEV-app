import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:flutter/material.dart';

class ClubSelectionViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  ClubSelectionViewModel();

  Future<void> selectClub(String club) async {
    _secureStorage.saveClub(club);
    notifyListeners();
  }
}