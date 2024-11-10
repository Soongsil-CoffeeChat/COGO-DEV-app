import 'package:cogo/common/navigator/view/bottom_navigation_bar.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/auth/login/login_screen.dart';
import 'package:cogo/features/auth/signup/views/mentee/interest_selection_screen.dart';
import 'package:cogo/features/auth/signup/views/mentor/club_selection_screen.dart';
import 'package:cogo/features/auth/signup/views/mentor/interest_selection_screen.dart';
import 'package:cogo/features/auth/signup/views/mentor/mentor_info_screen.dart';
import 'package:cogo/features/auth/signup/views/shared_views/agreement_screen.dart';
import 'package:cogo/features/auth/signup/views/shared_views/choose_role_screen.dart';
import 'package:cogo/features/auth/signup/views/shared_views/name_input_screen.dart';
import 'package:cogo/features/auth/signup/views/shared_views/phone_number_screen.dart';
import 'package:cogo/features/cogo/cogo_screen.dart';
import 'package:cogo/features/cogo/requested_cogo/requested_cogo_detail_screen.dart';
import 'package:cogo/features/cogo/requested_cogo/requested_cogo_screen.dart';
import 'package:cogo/features/cogo/success_cogo/successed_cogo_detail_screen.dart';
import 'package:cogo/features/cogo/success_cogo/successed_cogo_screen.dart';
import 'package:cogo/features/home/apply/views/matching_screen.dart';
import 'package:cogo/features/home/apply/views/memo_screen.dart';
import 'package:cogo/features/home/apply/views/schedule_screen.dart';
import 'package:cogo/features/home/home/view/home_screen.dart';
import 'package:cogo/features/home/mentor_detail/views/mentor_question1_screen.dart';
import 'package:cogo/features/home/mentor_detail/views/mentor_question2_screen.dart';
import 'package:cogo/features/home/profile/view/profile_detail_screen.dart';
import 'package:cogo/features/home/search/view/search_screen.dart';
import 'package:cogo/features/mypage/mentor_time_setting/mentor_time_setting_screen.dart';
import 'package:cogo/features/mypage/my_info/my_info_screen.dart';
import 'package:cogo/features/mypage/mypage_screen.dart';
import 'package:cogo/features/mypage/profile_management/mentor_introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/signup/views/shared_views/completion_screen.dart';

final AppRouter = GoRouter(
  // initialLocation: '/',
  initialLocation: Paths.home,
  routes: [
    GoRoute(
        path: Paths.login,
        pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const LoginScreen(),
            )),
    GoRoute(
      path: Paths.agreement,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const AgreementScreen(),
      ),
      routes: [
        GoRoute(
          path: Paths.phone,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const PhoneNumberScreen(),
          ),
        ),
        GoRoute(
          path: Paths.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const NameInputScreen(),
          ),
        ),
        GoRoute(
          path: Paths.choose,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ChooseRoleScreen(),
          ),
        ),
        GoRoute(
          path: Paths.mentorInterest,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const MentorInterestSelectionScreen(),
          ),
        ),
        GoRoute(
          path: Paths.mentorClub,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ClubSelectionScreen(),
          ),
        ),
        GoRoute(
          path: Paths.mentorInfo,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const MentorInfoScreen(),
          ),
        ),
        GoRoute(
          path: Paths.menteeInterest,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const MenteeInterestSelectionScreen(),
          ),
        ),
        GoRoute(
          path: Paths.completion,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const CompletionScreen(),
          ),
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(
          navigationShell: navigationShell,
        );
      },
      branches: [
        _createBranch(Paths.home, const HomeScreen()),
        _createBranch(Paths.cogo, const CogoScreen()),
        _createBranch(Paths.mypage, MypageScreen()),
      ],
    ),
    GoRoute(
      path: Paths.search,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SearchScreen(),
      ),
    ),
    GoRoute(
      path: Paths.schedule,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final mentorId = extra['mentorId'] as int;

        return ScheduleScreen(mentorId: mentorId);
      },
    ),
    GoRoute(
      path: Paths.memo,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MemoScreen(),
      ),
    ),
    GoRoute(
      path: Paths.matching,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MatchingScreen(),
      ),
    ),
    GoRoute(
      path: Paths.requestedCogo,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const RequestedCogoScreen(),
      ),
    ),
    GoRoute(
      path: Paths.requestedCogoDetail,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const RequestedCogoDetailScreen(),
      ),
    ),
    GoRoute(
      path: Paths.successedCogo,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SuccessedCogoScreen(),
      ),
    ),
    GoRoute(
      path: Paths.successedCogoDetail,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SuccessedCogoDetailScreen(),
      ),
    ),
    GoRoute(
      path: Paths.mentorIntroduction,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MentorIntroductionScreen(),
      ),
    ),
    GoRoute(
      path: Paths.mentorQuestion1,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MentorQuestion1Screen(),
      ),
    ),
    GoRoute(
      path: Paths.mentorQuestion2,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MentorQuestion2Screen(),
      ),
    ),
    /**
       * my page
       */
    GoRoute(
      path: Paths.myInfo,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MyInfoScreen(),
      ),
    ),
    GoRoute(
      path: Paths.introduce,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MentorIntroductionScreen(),
      ),
    ),
    GoRoute(
      path: Paths.profileDetail,
      builder: (context, state) {
        final mentorId = int.tryParse(state.uri.queryParameters['mentorId']!);
        if (mentorId == null) {
          throw Exception(
              'Invalid mentorId: ${state.uri.queryParameters['mentorId']}');
        }
        return ProfileDetailScreen(mentorId: mentorId);
      },
    ),
    GoRoute(
      path: Paths.timeSetting,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MentorTimeSettingScreen(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(
          navigationShell: navigationShell,
        );
      },
      branches: [
        _createBranch(Paths.home, const HomeScreen()),
        _createBranch(Paths.cogo, const CogoScreen()),
        _createBranch(Paths.mypage, MypageScreen()),
      ],
    ),
  ],
);

StatefulShellBranch _createBranch(String path, Widget child) {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: path,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: child,
        ),
      ),
    ],
  );
}
