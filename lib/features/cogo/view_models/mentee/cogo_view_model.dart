import 'package:cogo/common/navigator/view/bottom_navigation_bar.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CogoScreenViewModel extends ChangeNotifier {
  void navigateToReceivedCogo(BuildContext context) {
    context.push(Paths.sendedCogo);
  }

  void navigateToSuccessedCogo(BuildContext context) {
    Navigator.pushNamed(context, '/successedCogo');
  }
}
