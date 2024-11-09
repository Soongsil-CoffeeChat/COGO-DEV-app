import 'dart:developer';

import 'package:cogo/domain/entity/mentor_part_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/service/mentor_service.dart';

class HomeViewModel extends ChangeNotifier {
  String? selectedRole = "mentor";
  bool isIntroductionComplete = true; // 자기소개 완료 여부를 저장

  final MentorService _mentorService = MentorService(); // MentorService 객체 생성

  List<MentorPartEntity>? profiles;

  Future<void> onButtonPressed(BuildContext context, String title) async {
    final part = title; // API 호출에 사용할 mentorId
    try {
      final responseProfiles = await _mentorService.getMentorPart(part);
      profiles = responseProfiles
          .map((response) => MentorPartEntity.fromResponse(response))
          .toList();

      notifyListeners();
    } catch (error) {
      log('Error fetching mentor details: $error');
    }
  }

  void onProfileCardTapped(BuildContext context, String mentorId) {
    context.push('${Paths.profileDetail}?mentorId=$mentorId');
  }

  void onSearchPressed(BuildContext context) {
    context.push(Paths.search);
  }
}
