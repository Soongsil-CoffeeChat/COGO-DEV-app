import 'dart:developer';

import 'package:cogo/common/enums/interest.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClubSelectionViewModel extends ChangeNotifier {
  final UserService userService;
  String? selectedClub;
  Interest? interest;
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  ClubSelectionViewModel({required this.userService}) {}

  void selectClub(BuildContext context, String club) async {
    selectedClub = club;
    notifyListeners();

    _secureStorage.saveClub(club);

    interest = _secureStorage.readInterest() as Interest;
  }

  Future<void> signUpMentee(BuildContext context) async {
    try {
      //잘 전송이 되어야 넘어감
      await userService.signUpMentor(interest.toString(), selectedClub!);
      context.push('${Paths.agreement}/${Paths.completion}');

      notifyListeners();
    } catch (e) {
      log("Exception occurred: $e");
      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      notifyListeners();
    }
  }
}