import 'dart:developer';

import 'package:cogo/common/widgets/atoms/texts/styles.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dialogWidth = screenWidth - 40;

    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          width: dialogWidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Title
                    const Text(
                      '커피쳇 신청이 완료되었어요!',
                      style: CogoTextStyle.body16,
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    Text(
                      '멘토님께서 신청을 승인할 때까지 기다려 주세요.',
                      style: CogoTextStyle.body12
                          .copyWith(color: CogoColor.systemGray03),
                    ),
                    const SizedBox(height: 16),
                    // Image
                    Center(
                      child: Image.asset(
                        'assets/icons/3d_img/3d_rocket.png',
                        width: 130,
                        height: 130,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              // Close Button
              Positioned(
                top: -50,
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    'assets/icons/button/close.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
