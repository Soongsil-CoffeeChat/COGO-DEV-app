import 'package:flutter/material.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/dto/response/mentor_detail_response.dart';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailViewModel extends ChangeNotifier {
  MentorDetailResponse? profile;
  bool isLoading = true; // 로딩 상태를 나타내는 변수
  final MentorService _mentorService = MentorService(); // MentorService 객체 생성

  ProfileDetailViewModel() {
    fetchMentorDetail(); // 프로필 정보를 불러오기 위해 API 호출
  }

  // Mentor 상세 정보 불러오는 함수
  Future<void> fetchMentorDetail() async {
    final mentorId = '6'; // API 호출에 사용할 mentorId
    try {
      print('API 호출 시작');
      profile = await _mentorService.getMentorDetail(mentorId);
      print('API 호출 완료, mentorDetail: $profile');
    } catch (error) {
      // 에러 처리 로직
      print('Error fetching mentor details: $error');
    } finally {
      isLoading = false; // 로딩 완료 상태로 설정
      notifyListeners(); // 상태 갱신
    }
  }

  void applyForCogo(BuildContext context) {
    context.push(Paths.schedule);
  }
}
