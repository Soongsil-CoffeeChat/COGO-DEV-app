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

  ProfileDetailViewModel(int mentorId) {
    _loadData();
    fetchMentorDetail(mentorId);
  }

  Future<void> _loadData() async {
    role = await _secureStorage.readRole();
    notifyListeners();
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

  void applyForCogo(BuildContext context, int mentorId) {
    context.push(
      Paths.schedule,
      extra: {'mentorId': mentorId},
    );
  }
}
