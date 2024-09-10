import 'package:cogo/common/db/locale_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/constants/paths.dart';

class HomeViewModel extends ChangeNotifier {
  //String? selectedRole = LocaleManager.instance.getStringValue('selectedRole');
  String? selectedRole = "mentor";
  bool isIntroductionComplete = false; // 자기소개 완료 여부를 저장

  HomeViewModel() {
    _initialize();
  }

  // 비동기로 역할과 자기소개 완료 여부를 초기화
  Future<void> _initialize() async {
    selectedRole = await LocaleManager.instance.getStringValue('selectedRole');
    // 자기소개 완료 여부에 대한 값도 초기화
    isIntroductionComplete = await fetchIntroductionCompleteStatus();
    notifyListeners();
  }

  Future<bool> fetchIntroductionCompleteStatus() async {
    // 실제 자기소개 완료 여부를 불러오는 로직 추가
    return false; // 예시로 false 리턴
  }

  List<Map<String, dynamic>> profiles = [
    {
      'imagePath': 'assets/raccoon.png',
      'name': '나는 교휘',
      'clubName': 'GDSC',
      'tags': ['BE', '직무직무', '경력'],
    },
    {
      'imagePath': 'assets/raccoon.png',
      'name': '나는 교휘',
      'clubName': 'GDSC',
      'tags': ['BE', '직무직무', '경력'],
    },
    // 프로필 추가
  ];

  void onButtonPressed(BuildContext context, String title) {
    print('Button pressed: $title');
    // TODO : 버튼 액션 구현
    notifyListeners();
  }

  void onSearchPressed(BuildContext context) {
    context.push(Paths.search);
  }
}
