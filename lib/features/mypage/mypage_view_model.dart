import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MypageViewModel extends ChangeNotifier {
  void navigateToMyInformationManagement(BuildContext context) {
    context.push(Paths.myInfo);
  }

  void navigateToMentorIntroduceManagement(BuildContext context) {
    context.push(Paths.introduce);
  }

  void navigateToMentorTimeSetting(BuildContext context) {
    context.push(Paths.timeSetting);
  }
}
