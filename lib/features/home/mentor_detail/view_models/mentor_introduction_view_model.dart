import 'package:flutter/material.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/common/utils/routing_extension.dart';

class MentorIntroductionViewModel extends ChangeNotifier {
  // TextEditingController로 각 필드 관리
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController answer1Controller = TextEditingController();
  final TextEditingController answer2Controller = TextEditingController();

  bool isFormValid = false;

  // 각 텍스트 필드의 글자 수를 계산
  int get tittleCharCount => titleController.text.length;
  int get descriptionCharCount => descriptionController.text.length;
  int get answer1CharCount => answer1Controller.text.length;
  int get answer2CharCount => answer2Controller.text.length;

  MentorIntroductionViewModel() {
    // 각 컨트롤러에 리스너를 추가하여 값이 변경될 때마다 상태를 확인
    titleController.addListener(_validateFormIntro);
    descriptionController.addListener(_validateFormIntro);
    answer1Controller.addListener(_validateFormQuestion2);
    answer2Controller.addListener(_validateFormQuestion3);
  }

  // 텍스트 유효성 확인
  void _validateFormIntro() {
    isFormValid = titleController.text.isNotEmpty && descriptionController.text.isNotEmpty;
    notifyListeners();
  }

  void _validateFormQuestion2() {
    isFormValid = answer1Controller.text.isNotEmpty;
    notifyListeners();
  }

  void _validateFormQuestion3() {
    isFormValid = answer2Controller.text.isNotEmpty;
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

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    answer1Controller.dispose();
    answer2Controller.dispose();
    super.dispose();
  }
}