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
          navigationShell: navigationShell, // 명시적 캐스팅
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
