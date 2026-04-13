import 'dart:developer';

import 'package:cogo/common/utils/navigation_guard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

export 'package:cogo/common/utils/navigation_guard.dart';

extension RoutingExtension on BuildContext {
  void popUntil(String path) {
    while (canPop()) {
      final currentUrl = GoRouterState.of(this).uri.path;

      log('Current Path: $currentUrl, Target Path: $path');

      if (currentUrl == path) break;
      pop();
    }
  }
}
