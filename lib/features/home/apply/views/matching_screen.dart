import 'package:cogo/common/widgets/components/basic_button.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/features/home/apply/view_models/matching_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
                    'assets/icons/3d_img/3d_coffee.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<MatchingViewModel>(
                    builder: (context, viewModel, child) {
                      return BasicButton(
                        text: '코고 신청 완료하기',
                        isClickable: true,
                        onPressed: () => viewModel.completeApplication(
                            context, mentorId, possibleDateId, memo),
                        width: double.infinity,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
