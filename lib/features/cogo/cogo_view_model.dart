import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CogoViewModel extends ChangeNotifier {
  void navigateToReceivedCogo(BuildContext context) {
    context.push(Paths.unMatchedCogo);
  }

  void navigateToSuccessedCogo(BuildContext context) {
    context.push(Paths.matchedCogo);
  }
}
