import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
