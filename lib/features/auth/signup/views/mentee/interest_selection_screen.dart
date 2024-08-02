import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/view_models/mentee/interest_selection_view_model.dart';
import 'package:cogo/common/widgets/header.dart';
import 'package:cogo/common/widgets/custom_button.dart';

class MenteeInterestSelectionScreen extends StatelessWidget {
  const MenteeInterestSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenteeInterestSelectionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<MenteeInterestSelectionViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: '나의 관심사 또는 희망하는\n직종을 하나 선택해주세요',
                    subtitle: '나중에 관심사가 바뀌어도 수정이 가능해요',
                    onBackButtonPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                  text: 'FE',
                                  isSelected: viewModel.selectedInterest == 'FE',
                                  onPressed: () {
                                    viewModel.selectInterest(context, 'FE');
                                  },
                                ),
                                const SizedBox(width: 10),
                                CustomButton(
                                  text: 'BE',
                                  isSelected: viewModel.selectedInterest == 'BE',
                                  onPressed: () {
                                    viewModel.selectInterest(context, 'BE');
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                  text: '기획',
                                  isSelected: viewModel.selectedInterest == '기획',
                                  onPressed: () {
                                    viewModel.selectInterest(context, '기획');
                                  },
                                ),
                                const SizedBox(width: 10),
                                CustomButton(
                                  text: '디자인',
                                  isSelected: viewModel.selectedInterest == '디자인',
                                  onPressed: () {
                                    viewModel.selectInterest(context, '디자인');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}