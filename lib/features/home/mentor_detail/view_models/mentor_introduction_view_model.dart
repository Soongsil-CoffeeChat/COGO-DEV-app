import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:flutter/material.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/common/utils/routing_extension.dart';

class MentorIntroductionViewModel extends ChangeNotifier {
  // 각 텍스트 필드의 글자 수를 계산
  int get tittleCharCount => titleController.text.length;
  int get descriptionCharCount => descriptionController.text.length;
  int get answer1CharCount => answer1Controller.text.length;
  int get answer2CharCount => answer2Controller.text.length;

  // 각 텍스트 필드 컨트롤러
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController answer1Controller = TextEditingController();
  final TextEditingController answer2Controller = TextEditingController();

  final MentorService _mentorService = MentorService();
  bool isFormValid = false;

  MentorIntroductionViewModel() {
    titleController.addListener(_validateFormIntro);
    descriptionController.addListener(_validateFormIntro);
    answer1Controller.addListener(_validateFormQuestion2);
    answer2Controller.addListener(_validateFormQuestion3);

    _loadSavedValues();
  }

  void _validateFormIntro() {
    isFormValid = titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty;
    _saveToPreferences();
    notifyListeners();
  }

  void _validateFormQuestion2() {
    isFormValid = answer1Controller.text.isNotEmpty;
    _saveToPreferences();
    notifyListeners();
  }

  void _validateFormQuestion3() {
    isFormValid = answer2Controller.text.isNotEmpty;
    _saveToPreferences();
    notifyListeners();
  }

  void updateCharCount(TextEditingController controller) {
    notifyListeners();
  }

  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mentor_title', titleController.text);
    await prefs.setString('mentor_description', descriptionController.text);
    await prefs.setString('mentor_answer1', answer1Controller.text);
    await prefs.setString('mentor_answer2', answer2Controller.text);
  }

  // SharedPreferences에서 저장된 값 불러오기
  Future<void> _loadSavedValues() async {
    final prefs = await SharedPreferences.getInstance();
    titleController.text = prefs.getString('mentor_title') ?? '';
    descriptionController.text = prefs.getString('mentor_description') ?? '';
    answer1Controller.text = prefs.getString('mentor_answer1') ?? '';
    answer2Controller.text = prefs.getString('mentor_answer2') ?? '';
  }

  // 멘토 자기소개 입력 api 호출
  Future<void> saveIntroduction(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final title = prefs.getString('mentor_title') ?? '';
      final description = prefs.getString('mentor_description') ?? '';
      final answer1 = prefs.getString('mentor_answer1') ?? '';
      final answer2 = prefs.getString('mentor_answer2') ?? '';

      await _mentorService.patchMentorIntroduction(
          title, description, answer1, answer2);

      context.popUntil(Paths.home);
    } catch (e) {
      log('Failed to save introduction: $e');
    }
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
