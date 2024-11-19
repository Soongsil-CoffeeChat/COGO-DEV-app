import 'dart:developer';

import 'package:cogo/common/enums/interest.dart';
import 'package:cogo/common/enums/role.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InterestSelectionViewModel extends ChangeNotifier {
  final UserService userService;

  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  String? role;
  Interest? selectedInterest;

  InterestSelectionViewModel({required this.userService}) {
    _loadPreferences();
  }

  void _loadPreferences() async {
    // role = LocaleManager.instance.getStringValue('selectedRole');
    // var roleString = await _secureStorage.readRole();
    // role = Role.parseRole(roleString);
    // final roleString = await _secureStorage.readRole();
    // role = parseRole(roleString);
    role = await _secureStorage.readRole();

    log(role.toString());
    notifyListeners();
  }

  void selectInterest(BuildContext context, Interest interest) async {
    log(interest.name);
    selectedInterest = interest;
    notifyListeners();

    await _secureStorage.saveInterest(interest.name);
    // await LocaleManager.instance.setStringValue('SelectedInterest', interest);

    if (role == Role.MENTOR.name) {
      context.push('${Paths.agreement}/${Paths.mentorClub}');
    } else if (role == Role.MENTEE.name) {
      log("멘티입니다");
      signUpMentee(context, interest);
      context.push('${Paths.agreement}/${Paths.completion}');
    }
  }

  Future<void> signUpMentee(BuildContext context, Interest interest) async {
    try {
      //잘 전송이 되어야 넘어감
      await userService.signUpMentee(interest.name);
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
