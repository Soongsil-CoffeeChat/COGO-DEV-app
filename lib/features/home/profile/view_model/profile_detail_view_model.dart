import 'package:flutter/material.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/dto/response/mentor_detail_response.dart';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailViewModel extends ChangeNotifier {
  MentorDetailResponse? profile;
  bool isLoading = true; // 로딩 상태를 나타내는 변수
  final MentorService _mentorService = MentorService(); // MentorService 객체 생성

  ProfileDetailViewModel(String mentorId) {
    fetchMentorDetail(mentorId); // 프로필 정보를 불러오기 위해 API 호출
  }

  // Mentor 상세 정보 불러오는 함수
  Future<void> fetchMentorDetail(String mentorId) async {
    try {
      profile = await _mentorService.getMentorDetail(mentorId);
    } catch (error) {
      // 에러 처리 로직
      print('Error fetching mentor details: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void applyForCogo(BuildContext context) {
    context.push(Paths.schedule);
  }
}
