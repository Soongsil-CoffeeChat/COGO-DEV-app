import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 확인 버튼이 하나인 다이얼로그
class OneButtonDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String buttonText;
  final VoidCallback? onPressed;

  const OneButtonDialog(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imagePath,
      required this.buttonText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double dialogWidth = screenWidth - 40;
    final double imageSize = (screenHeight * 0.15).clamp(80.0, 130.0);

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: dialogWidth,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: CogoTextStyle.body16,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: CogoTextStyle.body12
                    .copyWith(color: CogoColor.systemGray03),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Image.asset(
                    imagePath,
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
              ),
              BasicButton(
                text: buttonText,
                isClickable: true,
                onPressed: onPressed,
                size: BasicButtonSize.LARGE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
