import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension RoutingExtension on BuildContext {
  void popUntil(String path) {
    while(true) {
      final currentUrl = GoRouterState.of(this).uri.path;
      if(currentUrl == path) break;
      pop();
    }
  }
}