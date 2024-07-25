import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/features/home/views/home_screen.dart';
import 'package:cogo/features/cogo/views/cogo_screen.dart';
import 'package:cogo/features/mypage/views/mypage_screen.dart';
import 'package:cogo/common/navigator/view/bottom_navigation_bar.dart';
import 'package:cogo/features/auth/signup/views/agreement_screen.dart';
import 'package:cogo/features/auth/signup/views/signup_screen_phone.dart';
import 'package:cogo/features/auth/signup/views/signup_screen_name.dart';
import 'package:cogo/features/auth/signup/views/signup_screen_choose.dart';
import 'package:cogo/features/auth/signup/views/mentor/interest_selection_screen.dart';
import 'package:cogo/features/auth/signup/views/mentor/club_selection_screen.dart';
import 'package:cogo/features/auth/signup/views/mentor/mentor_info_screen.dart';
import 'package:cogo/features/auth/signup/views/mentor/completion_screen.dart';
import 'package:cogo/features/auth/signup/views/mentee/interest_selection_screen.dart';
import 'package:cogo/features/auth/signup/views/mentee/completion_screen.dart';

final AppRouter = GoRouter(
  initialLocation: '/agreement',
  routes: [
    GoRoute(
      path: '/agreement',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: AgreementScreen(),
      ),
      routes: [
        GoRoute(
          path: 'phone',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: PhoneNumberVerificationScreen(),
          ),
          routes: [
            GoRoute(
              path: 'name',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: SignupScreenNameScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'choose',
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    child: SignupScreenChoose(),
                  ),
                  routes: [
                    GoRoute(
                      path: 'mentor_interest',
                      pageBuilder: (context, state) => MaterialPage(
                        key: state.pageKey,
                        child: InterestSelectionScreen(),
                      ),
                      routes: [
                        GoRoute(
                          path: 'mentor_club',
                          pageBuilder: (context, state) => MaterialPage(
                            key: state.pageKey,
                            child: ClubSelectionScreen(),
                          ),
                          routes: [
                            GoRoute(
                              path: 'mentor_info',
                              pageBuilder: (context, state) => MaterialPage(
                                key: state.pageKey,
                                child: MentorInfoScreen(),
                              ),
                                  routes: [
                                    GoRoute(
                                      path: 'mentor_completion',
                                      pageBuilder: (context, state) => MaterialPage(
                                        key: state.pageKey,
                                        child: MentorCompletionScreen(),
                                      ),
                                    ),
                                  ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'mentee_interest',
                      pageBuilder: (context, state) => MaterialPage(
                        key: state.pageKey,
                        child: MentesInterestSelectionScreen(),
                      ),
                      routes: [
                        GoRoute(
                          path: 'mentee_completion',
                          pageBuilder: (context, state) => MaterialPage(
                            key: state.pageKey,
                            child: MenteeCompletionScreen(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
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
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: HomeScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cogo',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: CogoScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/mypage',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: MypageScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
