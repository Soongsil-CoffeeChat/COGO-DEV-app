import 'dart:developer';

import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:cogo/domain/entity/mentor_part_entity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomeViewModel extends ChangeNotifier {
  // final MentorService mentorService;
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  String? role;

  final MentorService mentorService = GetIt.instance<MentorService>();

  HomeViewModel() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    role = await _secureStorage.readRole();
  }

  bool isIntroductionComplete = true; // 자기소개 완료 여부를 저장


  List<MentorPartEntity>? profiles;

  Future<void> onButtonPressed(BuildContext context, String title) async {
    final part = title; // API 호출에 사용할 mentorId
    try {
      final responseProfiles = await mentorService.getMentorPart(part);
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
