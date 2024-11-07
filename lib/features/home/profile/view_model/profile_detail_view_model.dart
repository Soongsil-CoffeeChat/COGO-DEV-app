import 'dart:developer';

import 'package:cogo/domain/entity/mentor_detail_entity.dart';
import 'package:flutter/material.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailViewModel extends ChangeNotifier {
  MentorDetailEntity? profile;
  bool isLoading = true; // 로딩 상태를 나타내는 변수
  final MentorService _mentorService = MentorService();

  ProfileDetailViewModel(int mentorId) {
    fetchMentorDetail(mentorId);
  }

  Future<void> fetchMentorDetail(int mentorId) async {
    try {
      final response = await _mentorService.getMentorDetail(mentorId);

      profile = MentorDetailEntity.fromResponse(response);
    } catch (error) {
      log('Error fetching mentor details: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void applyForCogo(BuildContext context) {
    context.push(Paths.schedule);
  }
}
