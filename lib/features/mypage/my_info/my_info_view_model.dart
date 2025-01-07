import 'dart:developer';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyInfoViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();

  String? _verificationCode; // 서버에서 받은 인증코드
  String? _message;

  String? get verificationCode => _verificationCode;
  String? get message => _message;

  // 원본 값(서버에서 받은 것)
  String _originalName = '';
  String _originalPhone = '';
  String _originalEmail = '';

  // TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneVerificationCodeController =
      TextEditingController();
  final TextEditingController emailVerificationCodeController =
      TextEditingController();

  // 인증코드 입력
  final TextEditingController codeController = TextEditingController();

  /// 수정 가능 여부 (이름 필드 예시)
  bool _isEditable = false;
  bool get isEditable => _isEditable;

  /// 전화번호 정규식 검사 결과
  final ValueNotifier<bool> isValidPhoneNumber = ValueNotifier<bool>(false);

  /// 코드 입력 검사 결과 (비어있지 않은지 정도만 확인)
  final ValueNotifier<bool> isValidCode = ValueNotifier<bool>(false);

  /// 에러 메시지 (전화번호/코드 검증 실패 시)
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  /// 인증번호 입력 필드 노출 여부
  final ValueNotifier<bool> showVerificationField = ValueNotifier<bool>(false);

  /// 휴대폰, 이메일 변경 여부 Getter
  bool get isPhoneChanged => phoneController.text != _originalPhone;
  bool get isEmailChanged => emailController.text != _originalEmail;

  /// 이메일 인증 버튼 상태
  bool _isClickEmailSendBtn = false;
  bool get isClickEmailSendBtn => _isClickEmailSendBtn;

  set isClickEmailSendBtn(bool value) {
    if (_isClickEmailSendBtn != value) {
      _isClickEmailSendBtn = value;
      notifyListeners(); // 값 변경 시 UI 업데이트
    }
  }

  MyInfoViewModel();

  /// 화면 진입 후, 실제 초기 로딩
  Future<void> initialize() async {
    await getMyInfo();

    // 이름 / 전화번호 / 이메일 변경 -> 수정 가능 여부 체크
    nameController.addListener(_checkIfChanged);
    phoneController.addListener(_checkIfChanged);

    // 전화번호 변경 -> 유효성 검사
    phoneController.addListener(_validatePhoneNumber);

    emailController.addListener(_checkIfChanged);

    // 인증코드 변경 -> 유효성 검사
    codeController.addListener(_validateCode);
  }

  /// 서버에서 내 정보 불러오기
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

  /// 이름 필드 기준 수정 가능 여부
  void _checkIfChanged() {
    notifyListeners();
    final nameChanged = (nameController.text != _originalName);
    if (_isEditable != nameChanged) {
      _isEditable = nameChanged;
      notifyListeners();
    }
  }

  /// 전화번호 유효성 검사
  void _validatePhoneNumber() {
    final phoneNumber = phoneController.text.replaceAll('-', '');
    final regex = RegExp(r'^\d{3}\d{4}\d{4}$');
    final isValid = regex.hasMatch(phoneNumber);

    isValidPhoneNumber.value = isValid;
    errorMessage.value = isValid ? null : '전화번호 형식을 확인하세요.';
  }

  /// 인증코드 유효성(비어있지 않은지 등) 검사
  void _validateCode() {
    isValidCode.value = codeController.text.isNotEmpty;
  }

  /// "인증하기" 버튼 탭 -> 서버에 인증코드 발송
  Future<void> onPhoneNumberSubmitted() async {
    if (isValidPhoneNumber.value) {
      // 전화번호가 유효하면 인증코드 발송 API 호출
      showVerificationField.value = true; // 인증코드 입력 필드 노출

      final cleanedPhoneNumber = phoneController.text.replaceAll('-', '');
      try {
        final result =
            await userService.sendVerificationCode(cleanedPhoneNumber);
        _verificationCode = result.verificationCode;
        errorMessage.value = null;
        log("Received verificationCode: $_verificationCode");
      } catch (e) {
        log("Exception occurred: $e");
        if (e is DioException) {
          log("DioError details: ${e.response?.data}");
        }
        _message = '인증번호 전송 중 오류가 발생했습니다.';
        errorMessage.value = _message;
      }

      notifyListeners();
    }
  }

  /// "확인" 버튼 탭 -> 사용자가 입력한 인증코드를 검증
  void checkVerificationCode() {
    if (isValidCode.value) {
      if (_verificationCode == codeController.text) {
        // 인증 성공 로직
        errorMessage.value = null;
        log("인증번호 일치 - 인증 성공");
      } else {
        // 인증 실패
        errorMessage.value = '인증번호가 일치하지 않습니다.';
      }
    } else {
      errorMessage.value = '인증번호를 입력해주세요.';
    }
  }

  void onEmailSendButtonClicked() {
    // TODO: 이메일 인증코드 발송 로직
    isClickEmailSendBtn = true;
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
