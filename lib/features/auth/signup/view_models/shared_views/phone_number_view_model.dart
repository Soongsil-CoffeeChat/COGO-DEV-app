import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/paths.dart';
import '../../../../../data/repository/remote/user_repository.dart';

class PhoneNumberViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  String? _phoneNumber;
  String? _verificationCode; //서버한테 받을 코드
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

  PhoneNumberViewModel({required this.userRepository}) {
    // 전화번호와 인증번호 입력 필드에 리스너 추가
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
    // 전화번호가 규격에 맞는지
    final phoneNumber = phoneController.text.replaceAll('-', '');
    final regex = RegExp(r'^\d{3}\d{4}\d{4}$'); // 전화번호 형식 확인
    final isValid = regex.hasMatch(phoneNumber);
    isValidPhoneNumber.value = isValid;
    errorMessage.value = isValid ? null : '전화번호 형식으로 입력해주세요';
  }

  void _validateCode() {
    // 인증코드가 입력되었는지
    isValidCode.value =
        codeController.text.isNotEmpty; //인증코드가 비었는지를 왜 코드가 매치인거지?
  }

  Future<void> onPhoneNumberSubmitted() async {
    //휴대폰 번호 제출 = 인증 코드 발송
    // 번호 제출
    if (isValidPhoneNumber.value) {
      isPhoneNumberSubmitted = true;
      showVerificationField.value = true; // 인증번호 필드 표시
      _phoneNumber = phoneController.text; // phoneController의 텍스트 사용
      final cleanedPhoneNumber = phoneController.text.replaceAll('-', '');

      try {
        final result =
            await userRepository.requestSmsVerification(cleanedPhoneNumber);
        log("Result from server: $result"); // Log the entire result

        if (result != null && result.verificationCode != null) {
          _verificationCode = result.verificationCode;
          log("Received verificationCode: $_verificationCode"); // Log the verification code
        } else {
          log("Received result is null or doesn't contain verificationCode");
        }

        notifyListeners();
      } catch (e) {
        log("Exception occurred: $e");
        if (e is DioException) {
          log("DioError details: ${e.response?.data}");
        }
        _message = 'An error occurred while sending verification code.';
        notifyListeners();
      }
      // } on DioError catch (e) {
      //   // 예외 처리 추가
      //   log("Exception occurred: $e");
      //   _message = 'An error occurred while sending verification code.';
      //   notifyListeners();
      // }
    }
  }

  void onVerificationCodeSubmitted(BuildContext context) {
    if (isValidCode.value) {
      // 사용자가 입력한 인증번호와 서버에서 받은 인증번호를 비교
      log("verificationCode: $_verificationCode, codeController.text ${codeController.text}");

      if (_verificationCode == codeController.text) {
        context.push("${Paths.agreement}/${Paths.name}");
      } else {
        errorMessage.value = '인증번호가 일치하지 않습니다.';
      }
    }
  }
}
