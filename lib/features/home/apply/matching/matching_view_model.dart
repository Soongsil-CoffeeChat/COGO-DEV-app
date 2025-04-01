import 'dart:developer';

import 'package:cogo/common/utils/routing_extension.dart';
import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/service/application_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class MatchingViewModel extends ChangeNotifier {
  final ApplicationService _applicationService = ApplicationService();

  Future<void> completeApplication(BuildContext context, int mentorId,
      int possibleDateId, String memo) async {
    try {
      final response = await _applicationService.postCogo(
        mentorId,
        possibleDateId,
        memo,
      );
      log("Cogo 신청 성공: ${response.toString()}");

      await _showSuccessDialog(context);
      context.go(Paths.home);

      notifyListeners();
    } on Exception catch (e) {
      log("Cogo 신청 실패: $e");
    }
  }

  Future<void> _showSuccessDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OneButtonDialog(
          title: "커피챗 신청이 완료되었어요!",
          subtitle: '멘토님께서 신청을 승인할때까지 기다려주세요',
          imagePath: 'assets/icons/3d_img/calendar.png',
          buttonText: '홈으로 돌아가기',
          onPressed: () => context.popUntil(Paths.home),
        );
      },
    );
  }
}
