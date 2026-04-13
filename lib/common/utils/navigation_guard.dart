import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

// 전역 플래그 — push 후 다음 frame 완료 전까지 추가 push 차단
bool _isNavigating = false;

/// context.push를 대체하는 안전 버전.
/// 동일 frame 내 중복 push → Navigator duplicate key assertion 방지.
///
/// 사용법:
///   기존: context.push(path)
///   변경: context.safePush(path)
extension SafeNavigationExtension on BuildContext {
  Future<T?> safePush<T extends Object?>(
    String location, {
    Object? extra,
  }) {
    if (_isNavigating) return Future.value(null);
    _isNavigating = true;
    final result = GoRouter.of(this).push<T>(location, extra: extra);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _isNavigating = false;
    });
    return result;
  }
}

/// ViewModel 등 BuildContext 없이 사용할 때의 헬퍼 (기존 호환용)
class NavigationGuard {
  NavigationGuard._();

  static void run(void Function() navigate) {
    if (_isNavigating) return;
    _isNavigating = true;
    navigate();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _isNavigating = false;
    });
  }
}
