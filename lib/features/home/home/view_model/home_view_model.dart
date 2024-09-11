import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/constants/paths.dart';

class HomeViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> profiles = [
    {
      'imagePath': 'assets/raccoonimg.png',
      'name': '김교휘',
      'tittle' : '한줄 소개 제목',
      'description' : '정말로다가 한줄만 적아야 할 거 같은 한줄 소개 칸이네요!',
      'clubName': 'GDSC',
      'tags': ['BE', '직무직무', '경력'],
    },
    {
      'imagePath': 'assets/default_img.png',
      'name': '윤영민',
      'tittle' : '한줄 소개 제목',
      'description' : '정말로다가 한줄만 적아야 할 거 같은 한줄 소개 칸이네요!',
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

  void onSearchPressed(BuildContext context) {
    context.push(Paths.search);
  }
}
