import 'dart:developer';
import 'package:cogo/common/enums/interest.dart';
import 'package:cogo/common/enums/role.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/domain/entity/mentor_part_entity.dart';
import 'package:cogo/domain/entity/my_mentor_entity.dart';
import 'package:cogo/domain/entity/my_page_info.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomeViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  final UserService userService = GetIt.instance<UserService>();

  bool? isIntroductionComplete;
  List<MentorPartEntity>? profiles;
  final MentorService mentorService = GetIt.instance<MentorService>();
  String? role;

  bool _shouldShowDialog = false;
  bool get shouldShowDialog => _shouldShowDialog;
  bool isInitialized = false;

  String _currentPart = Interest.FE.name;

  HomeViewModel() {
    loadPreferences();
    fetchUserData();
  }

  Future<void> loadPreferences() async {
    role = await _secureStorage.readRole();

    if (role == Role.ROLE_MENTOR.name) {
      await fetchIntroductionData();
      if (isIntroductionComplete == false) {
        _shouldShowDialog = true;
      }
    } else if (role == null) {
      final response = await userService.getUserInfo();
      await _secureStorage.saveRole(response.role);
    }
    isInitialized = true;
    notifyListeners();
  }

  Future<void> getProfilesForPart(String part) async {
    _currentPart = part; // 현재 파트 기억
    try {
      // (옵션) 탭 누를 때마다 로딩 보여주고 싶으면 여기서 profiles = null; notifyListeners();

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

  Future<void> refreshHome() async {
    // 1) 데이터를 null로 만들어 화면에 로딩 인디케이터가 뜨게 함 (시각적 리빌드 효과)
    profiles = null;
    notifyListeners();

    // 2) 데이터 병렬로 다시 불러오기 (설정 + 유저정보 + 현재 탭의 리스트)
    await Future.wait([
      loadPreferences(),
      fetchUserData(),
      getProfilesForPart(_currentPart), // 기억해둔 파트로 다시 요청
    ]);

    // getProfilesForPart 내부에서 finally로 notifyListeners()가 호출되므로
    // 여기서 따로 안 해도 되지만, 확실히 하기 위해 한 번 더 해도 무방함.
  }

  Future<void> fetchUserData() async {
    try {
      final response = await userService.getUserInfo();

      try {
        await _secureStorage.saveUserId(response.userId);
        log("✅ userId 저장 완료: ${response.userId}");
      } catch (e) {
        log("❌ userId 가져오기 실패: $e");
      }

      log('내 정보 조회 성공');
    } catch (e) {
      log('Error fetching user data: $e');
    } finally {}
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
