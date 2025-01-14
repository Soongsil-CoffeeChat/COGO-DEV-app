import 'dart:developer';

import 'package:cogo/data/service/mentor_service.dart';
import 'package:cogo/domain/entity/my_mentor_entity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyMentorIntroductionViewModel extends ChangeNotifier {
  final MentorService mentorService = GetIt.instance<MentorService>();

  MyMentorIntroductionUiState _state = const MyMentorIntroductionUiState();

  MyMentorIntroductionUiState get state => _state;

  // TextEditingController로 각 필드 관리
  final TextEditingController introController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController question1Controller = TextEditingController();
  final TextEditingController question2Controller = TextEditingController();

  bool isFormValid = false;

  // 각 텍스트 필드의 글자 수를 계산
  int get introCharCount => introController.text.length;

  int get descriptionCount => descriptionController.text.length;

  int get question1CharCount => question1Controller.text.length;

  int get question2CharCount => question2Controller.text.length;

  MyMentorIntroductionViewModel() {
    // 각 컨트롤러에 리스너를 추가하여 값이 변경될 때마다 상태를 확인

    introController.addListener(_validateForm);
    descriptionController.addListener(_validateForm);
    question1Controller.addListener(_validateForm);
    question2Controller.addListener(_validateForm);

    initialize();
  }

  void initialize() async {
    await fetchIntroductionData();
  }

  // 텍스트가 변경될 때마다 유효성 검사 수행
  void _validateForm() {
    isFormValid = introController.text.isNotEmpty &&
        question1Controller.text.isNotEmpty &&
        question2Controller.text.isNotEmpty &&
        descriptionController.text.isNotEmpty;
    notifyListeners();
  }

  // 글자 수 업데이트
  void updateCharCount(TextEditingController controller) {
    notifyListeners(); // 글자 수 변화를 알림
  }

  //데이터 불러오는 함수
  Future<void> fetchIntroductionData() async {
    _updateState(isLoading: true, hasError: false);

    try {
      var response = await mentorService.fetchMentorIntroduction();
      var data = MyMentorEntity.fromResponse(response);

      introController.text = data.introductionAnswer1;
      descriptionController.text = data.introductionDescription;
      question1Controller.text = data.introductionAnswer1;
      question2Controller.text = data.introductionAnswer2;
      _updateState(myMentorInfo: data);
      notifyListeners();
    } catch (e) {
      log('Failed to loading introduction: $e');
      _updateState(hasError: true);
    } finally {
      _updateState(isLoading: false);
    }
  }

  // 데이터를 저장하는 함수
  Future<bool> saveIntroduction() async {
    try {
      await mentorService.patchMentorIntroduction(
          introController.text,
          descriptionController.text,
          question1Controller.text,
          question2Controller.text);

      return true;
    } catch (e) {
      log('Failed to save introduction: $e');
      return false;
    }
  }

  // ViewModel이 제거될 때 Controller도 함께 해제
  @override
  void dispose() {
    introController.dispose();
    descriptionController.dispose();
    question1Controller.dispose();
    question2Controller.dispose();
    super.dispose();
  }

  void _updateState({
    bool? isLoading,
    bool? hasError,
    MyMentorEntity? myMentorInfo,
    String? role,
  }) {
    _state = _state.copyWith(
      isLoading: isLoading,
      hasError: hasError,
    );
    notifyListeners();
  }
}

class MyMentorIntroductionUiState {
  final bool isLoading;
  final bool hasError;

  const MyMentorIntroductionUiState({
    this.isLoading = false,
    this.hasError = false,
  });

  MyMentorIntroductionUiState copyWith({
    bool? isLoading,
    bool? hasError,
  }) {
    return MyMentorIntroductionUiState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
