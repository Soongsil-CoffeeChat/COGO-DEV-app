import 'package:flutter/material.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/common/widgets/atoms/texts/texts.dart';
import 'package:cogo/features/mypage/profile_management/views/mentor_introduction_screen.dart';

class MentorProfileDialog extends StatelessWidget {
  const MentorProfileDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: screenWidth - 20,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '멘토 활동을 시작하려면\n프로필 작성을 완료해주세요',
                  textAlign: TextAlign.left,
                  style: CogoTextStyle.header2,
                ),
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '입력하신 정보는 하단의 MY에서 수정이 가능해요',
                  textAlign: TextAlign.left,
                  style: CogoTextStyle.caption2,
                ),
              ),
              const SizedBox(height: 130),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    // 페이지 전환 애니메이션을 아래에서 위로 변경
                    Navigator.of(context).push(_createRoute());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CogoColor.buttonBackground,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    '멘토 프로필 작성하기',
                    style: CogoTextStyle.buttonText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 아래에서 위로 슬라이딩하는 페이지 전환 애니메이션
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MentorIntroductionScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // 아래에서 시작
        const end = Offset.zero; // 끝에서 멈춤 (화면에 완전히 표시됨)
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
