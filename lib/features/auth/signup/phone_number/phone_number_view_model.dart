import 'dart:developer';

import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // [수정] TextInput 사용을 위해 필요
import 'package:go_router/go_router.dart';

class PhoneNumberViewModel extends ChangeNotifier {
  final UserService userService;

  String? _verificationCode;
  String? _message;

  String? get verificationCode => _verificationCode;
  String? get message => _message;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final ValueNotifier<bool> isValidPhoneNumber = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isValidCode = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showVerificationField = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  bool isPhoneNumberSubmitted = false;

  PhoneNumberViewModel({required this.userService}) {
    phoneController.addListener(_validatePhoneNumber);
    codeController.addListener(_validateCode);
  }

  @override
  void dispose() {
    phoneController.removeListener(_validatePhoneNumber);
    phoneController.dispose();
    codeController.removeListener(_validateCode);
    codeController.dispose();
    isValidPhoneNumber.dispose();
    isValidCode.dispose();
    showVerificationField.dispose();
    errorMessage.dispose();
    super.dispose();
  }

  void _validatePhoneNumber() {
    final phoneNumber = phoneController.text.replaceAll('-', '');
    final regex = RegExp(r'^\d{3}\d{4}\d{4}$');
    final isValid = regex.hasMatch(phoneNumber);
    isValidPhoneNumber.value = isValid;
    errorMessage.value = isValid ? null : '전화번호 형식으로 입력해주세요';
  }

  void _validateCode() {
    isValidCode.value = codeController.text.isNotEmpty;
  }

  Future<void> onPhoneNumberSubmitted() async {
    if (isValidPhoneNumber.value) {
      isPhoneNumberSubmitted = true;
      showVerificationField.value = true;
      final cleanedPhoneNumber = phoneController.text.replaceAll('-', '');

      try {
        final result =
        await userService.sendVerificationCode(cleanedPhoneNumber);
        _verificationCode = result.verificationCode;
        log("Received verificationCode: $_verificationCode");
        notifyListeners();
      } catch (e) {
        log("Exception occurred: $e");
        if (e is DioException) {
          log("DioError details: ${e.response?.data}");
        }
        _message = 'An error occurred while sending verification code.';
        notifyListeners();
      }
    }
  }

  void onVerificationCodeSubmitted(BuildContext context) {
    if (isValidCode.value) {
      log("verificationCode: $_verificationCode, codeController.text ${codeController.text}");

      if (_verificationCode == codeController.text) {
        TextInput.finishAutofillContext();

        context.push("${Paths.agreement}/${Paths.name}",
            extra: phoneController.text);
      } else {
        errorMessage.value = '인증번호가 일치하지 않습니다.';
      }
    }
  }
}