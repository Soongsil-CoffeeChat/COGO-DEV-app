import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CogoViewModel extends ChangeNotifier {
  void navigateToReceivedCogo(BuildContext context) {
    context.push('/receivedCogo');
  }

  void navigateToSuccessedCogo(BuildContext context) {
    context.push('/successedCogo');
  }
}
