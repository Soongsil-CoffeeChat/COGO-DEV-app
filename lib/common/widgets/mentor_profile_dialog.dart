import 'package:flutter/material.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/common/widgets/atoms/texts/texts.dart';
import 'package:cogo/features/home/mentor_detail/views/mentor_introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MentorProfileDialog extends StatelessWidget {
  const MentorProfileDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dialogWidth = screenWidth - 40; // 전체 화면 너비에서 20을 뺀 값
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
                  const Text(
                    '멘토 활동을 시작하려면\n프로필 작성을 완료해주세요',
                    style: CogoTextStyle.body16,
                  ),
                  const Text(
                    '입력하신 정보는 하단의 MY에서 수정이 가능해요',
                    style: CogoTextStyle.body12,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Image.asset(
                        'assets/icons/3d_img/3d_heart.png',
                        width: 130,
                        height: 130,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(_createRoute()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CogoColor.systemGray05,
                      minimumSize: Size(dialogWidth, 50),
                    ),
                    child: Text(
                      '멘토 프로필 작성하기',
                      style: CogoTextStyle.button1
                          .copyWith(color: CogoColor.white50),
                    ),
                  ),
                ],
              ),
            ),
            // 닫기 버튼
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

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const MentorIntroductionScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.ease));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
