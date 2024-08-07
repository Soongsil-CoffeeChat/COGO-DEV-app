import 'package:flutter/material.dart';
import 'package:cogo/constants/paths.dart';
import 'package:go_router/go_router.dart';

class MatchingViewModel extends ChangeNotifier {
  void completeApplication(BuildContext context) {
    context.go(Paths.home);
  }
}
