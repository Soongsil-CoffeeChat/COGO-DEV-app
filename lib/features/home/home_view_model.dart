import 'dart:developer';
import 'package:cogo/common/enums/role.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:cogo/domain/entity/mentor_part_entity.dart';
import 'package:cogo/domain/entity/my_mentor_entity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomeViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  bool? isIntroductionComplete;
  List<MentorPartEntity>? profiles;
  final MentorService mentorService = GetIt.instance<MentorService>();
  String? role;

  bool _shouldShowDialog = false;
  bool get shouldShowDialog => _shouldShowDialog;
  bool isInitialized = false;

  HomeViewModel() {
    loadPreferences();
  }

  void loadPreferences() async {
    role = await _secureStorage.readRole();

    if (role == Role.ROLE_MENTOR.name) {
      await fetchIntroductionData();
      if (isIntroductionComplete == false) {
        _shouldShowDialog = true;
      }
    }
    isInitialized = true;
    notifyListeners();
  }

  Future<void> getProfilesForPart(String part) async {
    try {
      final responseProfiles = await mentorService.getMentorPart(part);
      profiles = responseProfiles
          .map((response) => MentorPartEntity.fromResponse(response))
          .toList();
    } catch (error) {
      log('Error fetching mentor details: $error');
    } finally {
      notifyListeners();
    }
  }

  /// 토큰으로 멘토 자기소개 4개 호출 (멘토 자기소개 다이얼로그 관리 용)
  Future<void> fetchIntroductionData() async {
    try {
      var response = await mentorService.fetchMentorIntroduction();
      log('${response.introductionTitle}');
      if (response.introductionTitle == null) {
        isIntroductionComplete = false;
      } else {
        log('Successed to loading introduction');
        isIntroductionComplete = true;
      }

      notifyListeners();
    } catch (e) {
      log('Failed to loading introduction: $e');
    }
  }

  void onProfileCardTapped(BuildContext context, String mentorId) {
    context.push('${Paths.profileDetail}?mentorId=$mentorId');
  }

  void onSearchPressed(BuildContext context) {
    context.push(Paths.search);
  }
}
