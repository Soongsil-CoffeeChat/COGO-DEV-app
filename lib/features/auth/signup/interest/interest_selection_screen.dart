import 'package:cogo/common/widgets/components/basic_button.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'interest_selection_view_model.dart';

class InterestSelectionScreen extends StatelessWidget {
  const InterestSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InterestSelectionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(  // SafeArea로 전체 화면을 감쌌습니다.
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<InterestSelectionViewModel>(
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
                                  BasicButton(
                                    text: 'FE',
                                    isClickable:
                                        viewModel.selectedInterest == 'FE',
                                    onPressed: () {
                                      viewModel.selectInterest(context, 'FE');
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  BasicButton(
                                    text: 'BE',
                                    isClickable:
                                        viewModel.selectedInterest == 'BE',
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
                                  BasicButton(
                                    text: '기획',
                                    isClickable:
                                        viewModel.selectedInterest == '기획',
                                    onPressed: () {
                                      viewModel.selectInterest(context, '기획');
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  BasicButton(
                                    text: '디자인',
                                    isClickable:
                                        viewModel.selectedInterest == '디자인',
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
      ),
    );
  }
}
