import 'package:flutter/material.dart';

class CogoScreenViewModel extends ChangeNotifier {
  void navigateToReceivedCogo(BuildContext context) {
    Navigator.pushNamed(context, '/receivedCogo');
  }

  void navigateToSuccessedCogo(BuildContext context) {
    Navigator.pushNamed(context, '/successedCogo');
  }
}
