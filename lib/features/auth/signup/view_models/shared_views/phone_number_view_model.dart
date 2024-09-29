import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../data/repository/remote/user_repository.dart';

class PhoneNumberVerificationViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  String? _phoneNumber;
  String? _verificationCode;
  String? _message;
  bool _isLoading = false;

  String? get phoneNumber => _phoneNumber;

  String? get verificationCode => _verificationCode;

  String? get message => _message;

  bool get isLoading => _isLoading;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final ValueNotifier<bool> isValidPhoneNumber = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isValidCode = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showVerificationField = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  bool isPhoneNumberSubmitted = false;

  PhoneNumberVerificationViewModel({required this.userRepository}) {
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
    final phoneNumber = phoneController.text.replaceAll('-', '');
    final regex = RegExp(r'^\d{3}\d{4}\d{4}$'); // 전화번호 형식 확인
    final isValid = regex.hasMatch(phoneNumber);
    isValidPhoneNumber.value = isValid;
    errorMessage.value = isValid ? null : '전화번호 형식으로 입력해주세요';
  }

  void _validateCode() {
    isValidCode.value = codeController.text.isNotEmpty;
  }

  Future<void> onPhoneNumberSubmitted() async {
    // 번호 제출
    if (isValidPhoneNumber.value) {
      isPhoneNumberSubmitted = true;
      showVerificationField.value = true; // 인증번호 필드 표시
      _phoneNumber = phoneController.text; // phoneController의 텍스트 사용
      final cleanedPhoneNumber = phoneController.text.replaceAll('-', '');

      final result =
          await userRepository.requestSmsVerification(cleanedPhoneNumber);

      // _verificationCode = result['verificationCode'];
      notifyListeners();
    }
  }

  void onVerificationCodeSubmitted(BuildContext context) {
    if (isValidCode.value) {
      context.push('/agreement/name');
    }
  }
}
