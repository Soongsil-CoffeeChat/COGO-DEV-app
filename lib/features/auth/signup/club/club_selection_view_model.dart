import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:flutter/material.dart';

class ClubSelectionViewModel extends ChangeNotifier {
  String? selectedClub;
  String? interest;
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  ClubSelectionViewModel();

  Future<void> selectClub(String club) async {
    selectedClub = club;
    notifyListeners();

    _secureStorage.saveClub(club);

    interest = await _secureStorage.readInterest();

    log("ClubSelectionViewModel selectedClub: $selectedClub interest $interest");
  }
}