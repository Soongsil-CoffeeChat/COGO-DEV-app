import 'dart:developer';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyInfoViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();

  /// TextEditingController 관리
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String get name => nameController.text;
  String get phone => phoneController.text;
  String get email => emailController.text;

  void updateName(String newName) {
    nameController.text = newName;
    notifyListeners();
  }

  void updatePhone(String newPhone) {
    phoneController.text = newPhone;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    emailController.text = newEmail;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  /// 초기 호출
  MyInfoViewModel() {
    initialize();
  }

  void initialize() async {
    await getMyInfo();
  }

  /// 기본정보 조회 api
  Future<void> getMyInfo() async {
    try {
      final response = await userService.getUserInfo();

      nameController.text = response.name;
      emailController.text = response.email ?? '';
      phoneController.text = response.phoneNum ?? '';

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
