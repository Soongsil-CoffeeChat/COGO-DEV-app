import 'package:flutter/material.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/common/utils/routing_extension.dart';

class MentorIntroductionViewModel extends ChangeNotifier {
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

  MentorIntroductionViewModel() {
    // 각 컨트롤러에 리스너를 추가하여 값이 변경될 때마다 상태를 확인
    introController.addListener(_validateFormIntro);
    question1Controller.addListener(_validateFormIntro);
    question2Controller.addListener(_validateFormQuestion2);
    question3Controller.addListener(_validateFormQuestion3);
  }

  void _validateFormIntro() {
    // introController와 question1Controller의 텍스트가 비어있지 않은지 확인합니다.
    isFormValid = introController.text.isNotEmpty && question1Controller.text.isNotEmpty;
    notifyListeners();
  }

  void _validateFormQuestion2() {
    // question2Controller의 텍스트가 비어있지 않은지 확인합니다.
    isFormValid = question2Controller.text.isNotEmpty;
    notifyListeners();
  }

  void _validateFormQuestion3() {
    // question3Controller의 텍스트가 비어있지 않은지 확인합니다.
    isFormValid = question3Controller.text.isNotEmpty;
    notifyListeners();
  }

  // 글자 수 업데이트
  void updateCharCount(TextEditingController controller) {
    notifyListeners(); // 글자 수 변화를 알림
  }

  // 데이터를 저장하는 함수
  void saveIntroduction(BuildContext context) {
    context.popUntil(Paths.home);
    //TODO : 데이터 저장 로직 구현

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