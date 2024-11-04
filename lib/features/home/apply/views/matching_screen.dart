import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/header.dart';
import 'package:cogo/features/home/apply/view_models/matching_view_model.dart';
import 'package:cogo/common/widgets/custom_button.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    width: 300,
                    height: 300,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<MatchingViewModel>(
                    builder: (context, viewModel, child) {
                      return CustomButton(
                        text: '코고 신청 완료하기',
                        isSelected: true,
                        onPressed: () => viewModel.completeApplication(context),
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
