import 'package:cogo/common/db/locale_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/constants/paths.dart';

class HomeViewModel extends ChangeNotifier {
  //String? selectedRole = LocaleManager.instance.getStringValue('selectedRole');
  String? selectedRole = "mentor";
  bool isIntroductionComplete = false; // 자기소개 완료 여부를 저장

  
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
