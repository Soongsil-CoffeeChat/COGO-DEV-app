import 'package:flutter/material.dart';
import 'package:cogo/features/home/profile/model/profile_detail_item.dart';

class SearchViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<String> selectedTags = []; // 선택된 태그 저장
  List<ProfileDetailModel> searchResults = []; // 검색 결과 저장
  final List<ProfileDetailModel> allProfiles = []; // 전체 프로필 목록
  bool hasSearched = false; // 검색이 완료되었는지 확인하는 상태 변수

  SearchViewModel() {
    // 전체 프로필 데이터 초기화
    allProfiles.addAll([
      ProfileDetailModel(
        imagePath: 'assets/raccoonimg.png',
        name: '김교휘',
        tittle: '한줄 소개 제목',
        description: '정말로다가 한줄만 적아야 할 거 같은 한줄 소개 칸이네요!',
        clubName: 'GDSC',
        tags: ['BE', '직무직무', '경력'],
        answer1: '',
        answer2: '',
      ),
      // 추가 프로필 데이터들...
    ]);
  }

  // 태그 선택 로직
  void toggleTagSelection(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
    notifyListeners();
  }

  // 검색 로직 구현
  void search(String query) {
    hasSearched = true; // 검색이 실행되었음을 표시
    searchResults = allProfiles.where((profile) {
      // 선택된 태그 중 하나라도 포함된 프로필을 검색 결과에 추가
      return selectedTags.any((tag) => profile.tags.contains(tag));
    }).toList();
    notifyListeners();
  }

  // 검색 초기화 메서드
  void clearSearch() {
    hasSearched = false; // 검색 상태 초기화
    searchResults.clear(); // 검색 결과 초기화
    selectedTags.clear(); // 선택된 태그 초기화
    notifyListeners(); // UI 업데이트를 위해 알림
  }

  bool isTagSelected(String tag) {
    return selectedTags.contains(tag);
  }
}
