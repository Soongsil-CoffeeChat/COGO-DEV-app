import 'dart:developer';

import 'package:cogo/data/service/mentor_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyMentorIntroductionViewModel extends ChangeNotifier {
  final MentorService mentorService = GetIt.instance<MentorService>();

  // TextEditingController로 각 필드 관리
  final TextEditingController introController = TextEditingController();
  final TextEditingController question1Controller = TextEditingController();
  final TextEditingController question2Controller = TextEditingController();
  final TextEditingController question3Controller = TextEditingController();

  bool isFormValid = false;

  // 각 텍스트 필드의 글자 수를 계산
  int get introCharCount => introController.text.length;

  int get question1CharCount => question1Controller.text.length;

  int get question2CharCount => question2Controller.text.length;

  int get question3CharCount => question3Controller.text.length;

  MyMentorIntroductionViewModel() {
    // 각 컨트롤러에 리스너를 추가하여 값이 변경될 때마다 상태를 확인
    introController.addListener(_validateForm);
    question1Controller.addListener(_validateForm);
    question2Controller.addListener(_validateForm);
    question3Controller.addListener(_validateForm);
  }

  // 텍스트가 변경될 때마다 유효성 검사 수행
  void _validateForm() {
    isFormValid = introController.text.isNotEmpty &&
        question1Controller.text.isNotEmpty &&
        question2Controller.text.isNotEmpty &&
        question3Controller.text.isNotEmpty;
    notifyListeners();
  }

  // 글자 수 업데이트
  void updateCharCount(TextEditingController controller) {
    notifyListeners(); // 글자 수 변화를 알림
  }

  // 데이터를 저장하는 함수
  Future<void> saveIntroduction(BuildContext context) async {
    try {
      await mentorService.patchMentorIntroduction(
          introController.text,
          question1Controller.text,
          question2Controller.text,
          question3Controller.text);
      Navigator.of(context).pop(); // 저장 후 화면 종료
    } catch (e) {
      log('Failed to save introduction: $e');
    }
  }

  // ViewModel이 제거될 때 Controller도 함께 해제
  @override
  void dispose() {
    introController.dispose();
    question1Controller.dispose();
    question2Controller.dispose();
    question3Controller.dispose();
    super.dispose();
  }
}
