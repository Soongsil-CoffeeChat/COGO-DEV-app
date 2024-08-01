import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
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

  void onButtonPressed(String title) {
    print('Button pressed: $title');
    // TODO : 버튼 액션 구현
    notifyListeners();
  }

  void onSearchPressed() {
    // TODO : 검색창 페이지로 넘기기
    notifyListeners();
  }
}
