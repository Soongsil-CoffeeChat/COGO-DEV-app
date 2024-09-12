import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<String> selectedTags = []; // 선택된 태그 저장
  final List<Map<String, dynamic>> searchResults = []; // 검색 결과

  // 태그를 검색 필드에 추가하는 함수
  void addTagToSearch(String tag) {
    if (!selectedTags.contains(tag)) {
      selectedTags.add(tag);
      updateSearchField();
      notifyListeners();
    }
  }

  // 검색 필드 업데이트
  void updateSearchField() {
    searchController.text = selectedTags.join(' ');
  }

  // 실제 검색 실행 (검색 아이콘을 눌렀을 때 호출)
  void search(String query) {
    // Implement the search logic here based on the 'query'
    // Update searchResults based on the search logic
    notifyListeners();
  }
}
