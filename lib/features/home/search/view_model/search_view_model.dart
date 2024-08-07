import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> profiles = [
    {
      'imagePath': 'assets/raccoon.png',
      'name': '나는 교휘',
      'clubName': 'GDSC',
      'tags': ['BE', '직무직무', '경력'],
      'description': '오늘도 아침엔 일에 밥을 먹고 똑같이 하루를 시작하고 운동일 한 손엔 아이스 아메리카노. 피곤해 죽겠네',
    },
    {
      'imagePath': 'assets/raccoon.png',
      'name': '나는 교휘',
      'clubName': 'GDSC',
      'tags': ['BE', '직무직무', '경력'],
      'description': '오늘도 아침엔 일에 밥을 먹고 똑같이 하루를 시작하고 운동일 한 손엔 아이스 아메리카노. 피곤해 죽겠네',
    },
    // 추가 프로필
  ];

  List<Map<String, dynamic>> searchResults = [];

  void search(String keyword) {
    if (keyword.isEmpty) {
      searchResults = [];
    } else {
      final lowerKeyword = keyword.toLowerCase();
      searchResults = profiles
          .where((profile) =>
      profile['name'].toLowerCase().contains(lowerKeyword) ||
          profile['clubName'].toLowerCase().contains(lowerKeyword) ||
          profile['description'].toLowerCase().contains(lowerKeyword) ||
          profile['tags'].any((tag) => tag.toLowerCase().contains(lowerKeyword)))
          .toList();
    }
    notifyListeners();
  }
}
