import 'dart:async';
import 'dart:developer';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyInfoViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();
  final MentorService mentorService = GetIt.instance<MentorService>();

  /// 휴대폰 인증 번호 타이머 설정
  Timer? _codeTimer;
  int _remainingSeconds = 0;
  int get remainingSeconds => _remainingSeconds;

  /// 이메일 인증 번호 타이머 설정
  Timer? _emailTimer;
  int _remainingEmailSeconds = 0;
  int get remainingEmailSeconds => _remainingEmailSeconds;

  /// 인증번호 받기 버튼 활성화 여부
  bool _canSendPhoneVerification = true;
  bool get canSendPhoneVerification => _canSendPhoneVerification;
  bool _canSendEmailVerification = true;
  bool get canSendEmailVerification => _canSendEmailVerification;

  /// 이미 인증번호 받기 버튼을 눌러서 현재 인증 진행 중 상태인지 확인하는 변수
  bool _isVerifyingPhone = false;
  bool get isVerifyingPhone => _isVerifyingPhone;
  bool _isVerifyingEmail = false;
  bool get isVerifyingEmail => _isVerifyingEmail;

  /// 인증 성공 확인 변수
  bool successPhoneVerificationCode = false;
  bool successEmailVerificationCode = false;

  /// 인증 번호를 담는 변수
  String? _phoneVerificationCode;
  String? _emailVerificationCode;

  String? _message;

  String? get phoneVerificationCode => _phoneVerificationCode;
  String? get message => _message;

  /// 서버에서 받은 사용자 정보(이름, 폰번호, 이메일)
  String _originalName = '';
  String _originalPhone = '';
  String _originalEmail = '';

  /// Text field 컨트롤러
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneVerificationCodeController =
      TextEditingController();
  final TextEditingController emailVerificationCodeController =
      TextEditingController();

  final ValueNotifier<bool> isValidPhoneNumber = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isValidCode = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);
  final ValueNotifier<bool> showVerificationField = ValueNotifier<bool>(false);

  bool get isPhoneChanged => phoneController.text != _originalPhone;
  bool get isEmailChanged => emailController.text != _originalEmail;

  bool _isClickEmailSendBtn = false;
  bool get isClickEmailSendBtn => _isClickEmailSendBtn;

  bool isEditable = false;

  set isClickEmailSendBtn(bool value) {
    if (_isClickEmailSendBtn != value) {
      _isClickEmailSendBtn = value;
      notifyListeners();
    }
  }

  MyInfoViewModel() {
    /// 인증 로직을 리셋을 위해 listener를 추가해서 입력값이 바뀔 때 실행되게 함
    phoneController.addListener(_onPhoneNumberChanged);
    emailController.addListener(_onEmailChanged);
  }

  /// 화면 초기화
  Future<void> initialize() async {
    await getMyInfo();
    phoneController.addListener(() => notifyListeners());
    emailController.addListener(() => notifyListeners());
  }

  /// 서버에서 회원 정보 불러오기
  Future<void> getMyInfo() async {
    try {
      final response = await userService.getUserInfo();

      nameController.text = response.name;
      phoneController.text = response.phoneNum ?? '';
      emailController.text = response.email ?? '';

      _originalName = response.name;
      _originalPhone = response.phoneNum ?? '';
      _originalEmail = response.email ?? '';

      notifyListeners();
    } catch (e) {
      log("Exception occurred: $e");
      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      notifyListeners();
    }
  }

  /// 인증번호 받기 버튼 → 서버에 인증코드 발송
  Future<void> onPhoneNumberSubmitted() async {
    // 이미 비활성화라면 return
    if (!_canSendPhoneVerification) return;

    if (isValidPhoneNumber.value) {
      // 인증 진행 중 상태로 전환
      _isVerifyingPhone = true;

      // 버튼 비활성화
      _canSendPhoneVerification = false;
      notifyListeners();

      // 타이머 설정 -> 3분
      _startCodeTimer(180);

      showVerificationField.value = true;
      final cleanedPhoneNumber = phoneController.text.replaceAll('-', '');
      try {
        final result =
            await userService.sendVerificationCode(cleanedPhoneNumber);
        _phoneVerificationCode = result.verificationCode;
        errorMessage.value = null;
        log("Received verificationCode: $_phoneVerificationCode");
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

  /// 휴대폰 "확인" 버튼 → 입력한 인증코드 검증
  void checkPhoneVerificationCode() {
    if (_phoneVerificationCode == phoneVerificationCodeController.text) {
      // 인증 성공
      successPhoneVerificationCode = true;

      // 타이머 중단
      _codeTimer?.cancel();
      _codeTimer = null;
      _remainingSeconds = 0;
      _canSendPhoneVerification = true;

      _isVerifyingPhone = false;
      showVerificationField.value = false;

      // 원본값 갱신
      _originalPhone = phoneController.text;

      isEditable = true;
      notifyListeners();
    } else {
      // 인증 실패
      errorMessage.value = '인증번호가 일치하지 않습니다.';
    }
  }

  /// 이메일 "인증하기" 버튼 탭 -> 서버에 이메일 인증코드 발송
  Future<void> onEmailSendButtonClicked() async {
    isClickEmailSendBtn = true;
    // 이미 비활성화 상태면 return
    if (!_canSendEmailVerification) return;

    _isVerifyingEmail = true;
    _canSendEmailVerification = false;
    notifyListeners();

    // 타이머 설정 -> 3분
    _startEmailTimer(180);

    try {
      final result =
          await userService.emailVerificationCode(emailController.text);
      _emailVerificationCode = result.code;
      errorMessage.value = null;
      log("Received verificationCode: $_emailVerificationCode");
    } catch (e) {
      log("Exception occurred: $e");
      if (e is DioException) {
        log("Di oError details: ${e.response?.data}");
      }
      _message = '인증번호 전송 중 오류가 발생했습니다.';
      errorMessage.value = _message;
    }

    notifyListeners();
  }

  /// "확인" 버튼 탭 -> 사용자가 입력한 이메일 인증코드를 검증
  void checkEmailVerificationCode() {
    if (_emailVerificationCode == emailVerificationCodeController.text) {
      // 인증 성공
      log("인증번호 일치 - 인증 성공");
      successEmailVerificationCode = true;

      // 타이머 종료
      _emailTimer?.cancel();
      _emailTimer = null;
      _remainingEmailSeconds = 0;
      _canSendEmailVerification = true;

      _isVerifyingEmail = false;
      isClickEmailSendBtn = false;
      _originalEmail = emailController.text;

      isEditable = true;
      notifyListeners();
    } else {
      // 인증 실패
      errorMessage.value = '인증번호가 일치하지 않습니다.';
    }
  }

  /// 수정된 사용자 정보 저장하기
  Future<void> updateUserInfo() async {
    try {
      await userService.patchUserInfo(
          phoneController.text, nameController.text, emailController.text);
      isEditable = false;
    } catch (e) {
      log("Exception occurred: $e");
      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      errorMessage.value = _message;
    }

    notifyListeners();
  }

  /// 타이머 설정
  void _startEmailTimer(int totalSeconds) {
    _emailTimer?.cancel(); // 혹시 이미 진행 중인 타이머가 있으면 취소

    _remainingEmailSeconds = totalSeconds;
    notifyListeners();

    _emailTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingEmailSeconds > 0) {
        _remainingEmailSeconds--;
        notifyListeners();
      } else {
        // 0초가 되면 타이머 종료 + 버튼 재활성화
        timer.cancel();
        _emailTimer = null;
        _remainingEmailSeconds = 0;
        _canSendEmailVerification = true;
        notifyListeners();
      }
    });
  }

  /// 카운트다운 타이머
  void _startCodeTimer(int totalSeconds) {
    _codeTimer?.cancel();

    _remainingSeconds = totalSeconds;
    notifyListeners();

    _codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        // 시간 다됨 → 타이머 종료 + 버튼 재활성화
        timer.cancel();
        _codeTimer = null;
        _remainingSeconds = 0;
        _canSendPhoneVerification = true;
        notifyListeners();
      }
    });
  }

  /// 전화번호 정규식 검사
  bool validatePhoneNumber() {
    final phoneNumber = phoneController.text.replaceAll('-', '');
    final regex = RegExp(r'^\d{3}\d{4}\d{4}$');
    final isValid = regex.hasMatch(phoneNumber);
    isValidPhoneNumber.value = isValid;
    return isValid;
  }

  /* 이메일 인증 있을 시 코드
  void _onEmailChanged() {
    // 이미 인증 진행 중이라면 리셋
    if (_isVerifyingEmail) {
      _resetEmailVerificationState();
    }
    notifyListeners();
  }
   */

  /// 이메일 필드 변경 확인
  void _onEmailChanged() {
    // 인증 진행 중인 경우 초기화
    if (_isVerifyingEmail) {
      _resetEmailVerificationState();
    }

    // 이메일이 기존 값과 다르면 저장 가능 상태로 변경
    if (emailController.text != _originalEmail) {
      isEditable = true;
    } else {
      isEditable = false;
    }

    notifyListeners();
  }

  /// 전화번호가 바뀌면 -> 인증 로직 초기화
  void _onPhoneNumberChanged() {
    // 인증 진행 중인 상태에서 전화번호가 변경되면 리셋
    if (_isVerifyingPhone) {
      _resetPhoneVerificationState();
    }
    // 전화번호 유효성 검사
    validatePhoneNumber();
    notifyListeners();
  }

  /// 전화번호 인증 로직 초기화
  void _resetPhoneVerificationState() {
    _codeTimer?.cancel();
    _codeTimer = null;
    _remainingSeconds = 0;
    _canSendPhoneVerification = true;
    _isVerifyingPhone = false;
    showVerificationField.value = false;
    phoneVerificationCodeController.clear();
    successPhoneVerificationCode = false;
    notifyListeners();
  }

  void _resetEmailVerificationState() {
    _emailTimer?.cancel();
    _emailTimer = null;
    _remainingEmailSeconds = 0;
    _canSendEmailVerification = true;
    _isVerifyingEmail = false;

    isClickEmailSendBtn = false;
    emailVerificationCodeController.clear();
    successEmailVerificationCode = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    isValidPhoneNumber.dispose();
    isValidCode.dispose();
    showVerificationField.dispose();
    errorMessage.dispose();
    _codeTimer?.cancel();

    super.dispose();
  }
}
