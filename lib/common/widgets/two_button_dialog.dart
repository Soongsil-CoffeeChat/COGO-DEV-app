import 'package:cogo/common/widgets/atoms/texts/texts.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/home/mentor_detail/views/mentor_introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 확인 버튼이 두개인 다이얼로그
class TwoButtonDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String firstButtonText;
  final String secondButtonText;
  final VoidCallback? firstOnPressed;
  final VoidCallback? secondOnPressed;

  const TwoButtonDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.firstButtonText,
    required this.secondButtonText,
    required this.firstOnPressed,
    required this.secondOnPressed,
  }) : super(key: key);

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
                    style: CogoTextStyle.body12
                        .copyWith(color: CogoColor.systemGray03),
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
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: firstOnPressed,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: CogoColor.white50,
                            minimumSize: const Size(0, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                color: CogoColor.systemGray03,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Text(
                            firstButtonText,
                            style: CogoTextStyle.body16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: secondOnPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CogoColor.systemGray05,
                            minimumSize: const Size(0, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            secondButtonText,
                            style: CogoTextStyle.body16.copyWith(
                              color: CogoColor.white50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
    );
  }
}
