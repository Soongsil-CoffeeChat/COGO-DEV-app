import 'package:cogo/common/enums/role.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:flutter/material.dart';

class ChooseRoleViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  void selectRole(Role role) async {
    await _secureStorage.saveRole(role.name);
    notifyListeners();
  }

}
