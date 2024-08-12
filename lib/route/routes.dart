import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/features/home/views/home_screen.dart';
import 'package:cogo/features/cogo/views/mentor/cogo_screen.dart';
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
import 'package:cogo/features/cogo/views/mentor/received_cogo_screen.dart';
import 'package:cogo/features/cogo/views/mentor/received_cogo_detail_screen.dart';
import 'package:cogo/features/cogo/views/mentor/successed_cogo_screen.dart';
import 'package:cogo/features/cogo/views/mentor/successed_cogo_detail_screen.dart';


final AppRouter = GoRouter(
  initialLocation: Paths.cogo,
  routes: [
    GoRoute(
      path: Paths.agreement,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: AgreementScreen(),
      ),
      routes: [
        GoRoute(
          path: Paths.phone,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: PhoneNumberVerificationScreen(),
          ),
        ),
        GoRoute(
          path: Paths.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: SignupScreenNameScreen(),
          ),
        ),
        GoRoute(
          path: Paths.choose,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: SignupScreenChoose(),
          ),
        ),
        GoRoute(
          path: Paths.mentorInterest,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: MentorInterestSelectionScreen(),
          ),
        ),
        GoRoute(
          path: Paths.mentorClub,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: ClubSelectionScreen(),
          ),
        ),
        GoRoute(
          path: Paths.mentorInfo,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: MentorInfoScreen(),
          ),
        ),
        GoRoute(
          path: Paths.mentorCompletion,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: MentorCompletionScreen(),
          ),
        ),
        GoRoute(
          path: Paths.menteeInterest,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: MenteeInterestSelectionScreen(),
          ),
        ),
        GoRoute(
          path: Paths.menteeCompletion,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: MenteeCompletionScreen(),
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
        _createBranch(Paths.home, HomeScreen()),
        _createBranch(Paths.cogo, CogoScreen()),
        _createBranch(Paths.mypage, MypageScreen()),
      ],
    ),
    GoRoute(
      path: Paths.receivedCogo,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ReceivedCogoScreen(),
      ),
    ),
    GoRoute(
      path: Paths.receivedCogoDetail,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ReceivedCogoDetailScreen(),
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
