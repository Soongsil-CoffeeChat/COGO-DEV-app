import 'package:cogo/common/utils/routing_extension.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'matching_view_model.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;

    if (extra == null ||
        !extra.containsKey('mentorId') ||
        !extra.containsKey('possibleDateId') ||
        !extra.containsKey('memoContent')) {
      throw Exception('필요한 데이터가 전달되지 않았습니다: $extra');
    }

    final mentorId = extra['mentorId'] as int;
    final possibleDateId = extra['possibleDateId'] as int;
    final memo = extra['memoContent'] as String;

    return ChangeNotifierProvider(
      create: (_) => MatchingViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Header(
                    title: '멘토님과의 매칭이 곧 이루어질 예정이에요!',
                    subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
                    onBackButtonPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Image.asset(
                    'assets/icons/3d_img/coffee.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Consumer<MatchingViewModel>(
                        builder: (context, viewModel, child) {
                          return BasicButton(
                            text: '코고 신청 완료하기',
                            isClickable: true,
                            onPressed: () => viewModel.completeApplication(
                                context, mentorId, possibleDateId, memo),
                            size: BasicButtonSize.LARGE,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          _showCancelDialog(context);
                        },
                        child: Text(
                          '처음으로 돌아가기',
                          style: CogoTextStyle.body9.copyWith(
                            color: CogoColor.systemGray03,
                            decoration: TextDecoration.underline,
                            decorationColor: CogoColor.systemGray03,
                            decorationThickness: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCancelDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OneButtonDialog(
          title: "정말 돌아가시겠어요?",
          subtitle: '돌아가시게 되면 작성하신 내용이 모두 사라져요',
          imagePath: 'assets/icons/3d_img/caution.png',
          buttonText: '홈으로 돌아가기',
          onPressed: () => context.popUntil(Paths.home),
        );
      },
    );
  }
}
