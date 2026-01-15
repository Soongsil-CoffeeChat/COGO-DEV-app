import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/domain/entity/mentor_detail_entity.dart';
import 'package:flutter/material.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();

  MentorDetailEntity? profile;
  bool isLoading = true;
  final MentorService _mentorService = MentorService();
  String? role;

  int? currentUserId;
  int? reportedUserId;

  ProfileDetailViewModel(int mentorId) {
    _loadData();
    fetchMentorDetail(mentorId);
  }

  Future<void> _loadData() async {
    role = await _secureStorage.readRole();
    currentUserId = await _secureStorage.getUserId();

    ///TODO 롤 잘 안물림 이슈
    log("롤은요 : $role");
    notifyListeners();
  }

  Future<void> fetchMentorDetail(int mentorId) async {
    try {
      final response = await _mentorService.getMentorDetail(mentorId);
      //TODO 실제 멘토의 유저 아이디로 변경
      reportedUserId = response.mentorId;

      profile = MentorDetailEntity.fromResponse(response);
    } catch (error) {
      log('Error fetching mentor details: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void applyForCogo(BuildContext context, int mentorId) {
    context.push(
      Paths.schedule,
      extra: {'mentorId': mentorId},
    );
  }

  void report(BuildContext context){
    context.push(
      Paths.report,
      extra: {
      'reporterId': currentUserId,
      'reportedUserId': reportedUserId,
    },
    );
  }
}
