import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/features/home/home/view/home_screen.dart';
import 'package:cogo/features/home/profile/view/profile_detail_screen.dart';
import 'package:cogo/features/home/search/view/search_screen.dart';
import 'package:cogo/features/home/apply/views/schedule_screen.dart';
import 'package:cogo/features/home/apply/views/memo_screen.dart';
import 'package:cogo/features/home/apply/views/matching_screen.dart';
import 'package:cogo/features/cogo/views/cogo_screen.dart';
import 'package:cogo/features/mypage/views/mypage_screen.dart';
import 'package:cogo/common/navigator/view/bottom_navigation_bar.dart';
import 'package:cogo/features/auth/signup/views/shared_views/agreement_screen.dart';
import 'package:cogo/features/auth/signup/views/shared_views/signup_screen_phone.dart';
import 'package:cogo/features/auth/signup/views/shared_views/signup_screen_name.dart';
import 'package:cogo/features/auth/signup/views/shared_views/signup_screen_choose.dart';
import 'package:cogo/features/auth/signup/views/mentor/interest_selection_screen.dart';
import 'package:cogo/features/auth/signup/views/mentor/club_selection_screen.dart';
import 'package:cogo/features/auth/signup/views/mentor/mentor_info_screen.dart';
import 'package:cogo/features/auth/signup/views/mentor/completion_screen.dart';
import 'package:cogo/features/auth/signup/views/mentee/interest_selection_screen.dart';
import 'package:cogo/features/auth/signup/views/mentee/completion_screen.dart';
import 'package:cogo/constants/paths.dart';

final AppRouter = GoRouter(
  initialLocation: Paths.home,
  routes: [
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
            child: const PhoneNumberVerificationScreen(),
          ),
        ),
        GoRoute(
          path: Paths.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SignupScreenNameScreen(),
          ),
        ),
        GoRoute(
          path: Paths.choose,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SignupScreenChoose(),
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
          path: Paths.mentorCompletion,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const MentorCompletionScreen(),
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
          path: Paths.menteeCompletion,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const MenteeCompletionScreen(),
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
        _createBranch(Paths.cogo, CogoScreen()),
        _createBranch(Paths.mypage, MypageScreen()),
      ],
    ),
    GoRoute(
      path: Paths.profileDetail,
      pageBuilder: (context, state) {
        final profile = state.extra as Map<String, dynamic>;
        return MaterialPage(
          key: state.pageKey,
          child: ProfileDetailScreen(
            imagePath: profile['imagePath'],
            name: profile['name'],
            clubName: profile['clubName'],
            tags: profile['tags'],
          ),
        );
      },
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
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ScheduleScreen(),
      ),
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
