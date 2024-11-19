import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MypageViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  String? role;

  MypageViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    role = await _secureStorage.readRole();
  }

  void navigateToMyInformationManagement(BuildContext context) {
    context.push(Paths.myInfo);
  }

  void navigateToMentorIntroduceManagement(BuildContext context) {
    context.push(Paths.introduce);
  }

  void navigateToMentorTimeSetting(BuildContext context) {
    context.push(Paths.timeSetting);
  }
}
