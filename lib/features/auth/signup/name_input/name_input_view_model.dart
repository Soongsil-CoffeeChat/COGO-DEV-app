import 'dart:developer';

import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/repository/local/locale_manager.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NameInputViewModel extends ChangeNotifier {
  final UserService userService;

  String? _phoneNumber;

  String? get phoneNumber => _phoneNumber;

  final TextEditingController nameController = TextEditingController();
  final ValueNotifier<bool> isValidName = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  NameInputViewModel({required this.userService}) {
    nameController.addListener(_validateName);
  }

  @override
  void dispose() {
    nameController.removeListener(_validateName);
    nameController.dispose();
    isValidName.dispose();
    errorMessage.dispose();
    super.dispose();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners(); // UI를 업데이트하기 위해 알림
  }

  Future<void> _validateName() async {
    final name = nameController.text;
    final isValid = name.isNotEmpty;
    isValidName.value = isValid;
    errorMessage.value = isValid ? null : '성함을 입력해주세요';

    await LocaleManager.instance.setStringValue('name', name);
  }

  Future<void> onConfirmButtonPressed(BuildContext context) async {
    if (isValidName.value) {
      try {
        //잘 전송이 되어야 넘어감
        await userService.setUserInfo(phoneNumber!, nameController.text);
        context.push('${Paths.agreement}/${Paths.choose}');

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
}
