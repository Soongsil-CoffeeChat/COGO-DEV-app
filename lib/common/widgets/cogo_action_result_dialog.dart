import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';

/// 코고 수락/거절 확인 다이얼로그
class CogoActionResultDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onPressed;

  const CogoActionResultDialog(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.buttonText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: 350,
        height: 170,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: CogoTextStyle.body14,
                  ),
                  Text(
                    subtitle,
                    style: CogoTextStyle.body9
                        .copyWith(color: CogoColor.systemGray04),
                    textAlign: TextAlign.center,
                  ),
                  BasicButton(
                    text: buttonText,
                    isClickable: true,
                    onPressed: onPressed,
                    size: BasicButtonSize.LARGE,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
