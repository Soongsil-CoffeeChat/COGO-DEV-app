import 'dart:developer';
import 'package:cogo/data/dto/response/my_info_response.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyInfoViewModel extends ChangeNotifier {
  final UserService userService;

  MyInfoViewModel({required this.userService});

  // TextEditingController 선언
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // 컨트롤러에서 값을 가져오는 메서드
  String get name => nameController.text;
  String get phone => phoneController.text;
  String get email => emailController.text;

  // 컨트롤러 값 변경 후 알림
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

  // ViewModel이 Dispose될 때 컨트롤러 정리
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // API 호출하여 데이터 가져오기
  Future<void> getMyInfo() async {
    try {
      // API 호출
      final response = await userService.getUserInfo();

      print("이름: ${response.name}");
      // 컨트롤러에 값 설정
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
