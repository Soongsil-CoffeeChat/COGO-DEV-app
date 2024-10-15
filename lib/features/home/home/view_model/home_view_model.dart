import 'package:cogo/data/dto/response/mentor_part_response.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/service/mentor_service.dart';

class HomeViewModel extends ChangeNotifier {
  //String? selectedRole = LocaleManager.instance.getStringValue('selectedRole');
  String? selectedRole = "mentor";
  bool isIntroductionComplete = true; // 자기소개 완료 여부를 저장

  List<MentorPartResponse>? profiles;

  final MentorService _mentorService = MentorService(); // MentorService 객체 생성


  Future<void> onButtonPressed(BuildContext context, String title) async {
    final part = title; // API 호출에 사용할 mentorId
    try {
      print('API 호출 시작');
      profiles = await _mentorService.getMentorPart(part);
      print("API 호출$profiles");
      notifyListeners();
    } catch (error) {
      // 에러 처리 로직
      print('Error fetching mentor details: $error');
    }
  }


  void onProfileCardTapped(BuildContext context) {
    context.push(Paths.profileDetail);
  }

  void onSearchPressed(BuildContext context) {
    context.push(Paths.search);
  }
}
