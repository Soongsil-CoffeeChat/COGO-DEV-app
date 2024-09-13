import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<String> selectedTags = []; // 선택된 태그 저장
  final List<Map<String, dynamic>> searchResults = []; // 검색 결과

  // 태그 버튼 목록 정의 (예시 태그 목록)
  final List<Map<String, String>> tagButtons = [
    {'text': '기획'},
    {'text': '디자인'},
    {'text': 'FE'},
    {'text': 'BE'},
    {'text': '전체'},
    {'text': 'GDSC'},
    {'text': 'YOURSSU'},
    {'text': 'UMC'},
    {'text': 'LIKELION'},
  ];

  // 태그를 검색 필드에 추가하는 함수
  void toggleTagSelection(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
    updateSearchField(); // 선택된 태그를 검색창에 업데이트
    notifyListeners();
  }

  // 검색 필드 업데이트
  void updateSearchField() {
    searchController.text = selectedTags.join(' '); // 선택된 태그들을 검색창에 표시
  }

  // 검색 실행 함수 (검색 아이콘을 눌렀을 때 호출)
  void search(String query) {
    // 검색 로직을 구현
    notifyListeners();
  }

  //선택된 태그가 있는지
  bool isTagSelected(String tag) {
    return selectedTags.contains(tag);
  }

  // 태그 제거 함수
  void removeTag(String tag) {
    selectedTags.remove(tag);
    notifyListeners();
  }
}
