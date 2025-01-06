import 'dart:developer';
import 'package:cogo/data/dto/response/my_info_response.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyInfoViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();

  /// 초기 로드된(서버에서 받은) 원본 값들을 저장
  String _originalName = '';
  String _originalPhone = '';
  String _originalEmail = '';

  /// TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  /// 버튼 활성화 여부
  bool _isEditable = false;
  bool get isEditable => _isEditable;

  MyInfoViewModel() {
    initialize();
  }

  /// ViewModel 초기화(데이터 불러오기)
  Future<void> initialize() async {
    await getMyInfo();

    /// TextField 변화 감지 리스너를 붙인다
    nameController.addListener(_checkIfChanged);
    phoneController.addListener(_checkIfChanged);
    emailController.addListener(_checkIfChanged);
  }

  /// API 호출하여 데이터 가져오기
  Future<void> getMyInfo() async {
    try {
      // API 호출
      final response = await userService.getUserInfo();

      // 컨트롤러에 값 설정
      nameController.text = response.name;
      phoneController.text = response.phoneNum ?? '';
      emailController.text = response.email ?? '';

      // 원본 값도 저장
      _originalName = response.name;
      _originalPhone = response.phoneNum ?? '';
      _originalEmail = response.email ?? '';

      // 초기 로드 시점에서는 변경된 게 없으므로 버튼 비활성화
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

  /// 현재 입력값 vs 원본값을 비교해서 다르면 _isEditable을 true로
  void _checkIfChanged() {
    final isNameChanged = (nameController.text != _originalName);
    final isPhoneChanged = (phoneController.text != _originalPhone);
    final isEmailChanged = (emailController.text != _originalEmail);

    final hasAnyChange = isNameChanged || isPhoneChanged || isEmailChanged;

    if (_isEditable != hasAnyChange) {
      _isEditable = hasAnyChange;
      notifyListeners();
    }
  }

  /// Dispose 시 컨트롤러 정리
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
