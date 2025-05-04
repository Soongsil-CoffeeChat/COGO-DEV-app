import 'package:cogo/common/widgets/widgets.dart';
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
    final double dialogWidth = screenWidth - 40;
    final double dialogHeight = dialogWidth;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: CogoTextStyle.body16,
                  ),
                  Text(
                    subtitle,
                    style: CogoTextStyle.body12,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Image.asset(
                        imagePath,
                        width: 130,
                        height: 130,
                      ),
                    ),
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
            Positioned(
              top: -50,
              right: 0,
              child: GestureDetector(
                onTap: () => Navigator.of(context, rootNavigator: true).pop(),
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
    );
  }
}
