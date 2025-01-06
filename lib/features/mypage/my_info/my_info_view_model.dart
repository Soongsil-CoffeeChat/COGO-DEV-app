import 'dart:developer';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyInfoViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();

  String? _verificationCode;
  String? _message;

  String? get verificationCode => _verificationCode;
  String? get message => _message;

  /// 원본 값(서버에서 받은 것)
  String _originalName = '';
  String _originalPhone = '';
  String _originalEmail = '';

  /// TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ValueNotifier<bool> isValidPhoneNumber = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isValidCode = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);
  final TextEditingController codeController = TextEditingController();
  final ValueNotifier<bool> showVerificationField = ValueNotifier<bool>(false);

  /// 수정 가능 여부
  bool _isEditable = false;
  bool get isEditable => _isEditable;
  bool isPhoneNumberSubmitted = false;

  /// 휴대폰, 이메일 변경 여부 Getter
  bool get isPhoneChanged => phoneController.text != _originalPhone;
  bool get isEmailChanged => emailController.text != _originalEmail;

  MyInfoViewModel() {}

  /// 화면 진입 후, 실제 초기 로딩
  Future<void> initialize() async {
    await getMyInfo();

    // Controller 값이 바뀔 때마다 _isEditable 갱신
    nameController.addListener(_checkIfChanged);
    phoneController.addListener(_checkIfChanged);
    emailController.addListener(_checkIfChanged);
  }

  /// 기본 정보 호출 api
  Future<void> getMyInfo() async {
    try {
      final response = await userService.getUserInfo();

      // 컨트롤러에 값 설정
      nameController.text = response.name;
      phoneController.text = response.phoneNum ?? '';
      emailController.text = response.email ?? '';

      // 원본 값 저장
      _originalName = response.name;
      _originalPhone = response.phoneNum ?? '';
      _originalEmail = response.email ?? '';

      // 초기 상태에서 수정 사항 없음
      _isEditable = false;
      notifyListeners();
    } catch (e) {
      log("Exception occurred: $e");
      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      notifyListeners();
    }
  }

  /// 현재 값 vs 원본 값 비교
  void _checkIfChanged() {
    notifyListeners();
    final nameChanged = (nameController.text != _originalName);

    if (_isEditable != nameChanged) {
      _isEditable = nameChanged;
      notifyListeners();
    }
  }

  /// 전화번호가 규격에 맞는지 ghkrdls
  void _validatePhoneNumber() {
    final phoneNumber = phoneController.text.replaceAll('-', '');
    final regex = RegExp(r'^\d{3}\d{4}\d{4}$'); // 전화번호 형식 확인
    final isValid = regex.hasMatch(phoneNumber);
    isValidPhoneNumber.value = isValid;
    errorMessage.value = isValid ? null : '전화번호 형식으로 입력해주세요';
  }

  /// 인증코드가 입력되었는지 ghkrdls
  void _validateCode() {
    isValidCode.value = codeController.text.isNotEmpty;
  }

  Future<void> onPhoneNumberSubmitted() async {
    //휴대폰 번호 제출 = 인증 코드 발송
    // 번호 제출
    if (isValidPhoneNumber.value) {
      isPhoneNumberSubmitted = true;
      showVerificationField.value = true; // 인증번호 필드 표시
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
      // 사용자가 입력한 인증번호와 서버에서 받은 인증번호를 비교
      log("verificationCode: $_verificationCode, codeController.text ${codeController.text}");

      if (_verificationCode == codeController.text) {
        //Todo 인증번호 일치시 로직 구현
      } else {
        errorMessage.value = '인증번호가 일치하지 않습니다.';
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    codeController.removeListener(_validateCode);
    codeController.dispose();
    isValidPhoneNumber.dispose();
    isValidCode.dispose();
    showVerificationField.dispose();
    errorMessage.dispose();
    super.dispose();
  }
}
