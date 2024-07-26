import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/signup_custom_appbar.dart';
import 'package:cogo/features/auth/signup/views_model/mentor/interest_selection_view_model.dart';
import 'package:cogo/common/widgets/signup_custom_button.dart';

class InterestSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InterestSelectionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<InterestSelectionViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '나의 관심사 또는 희망하는 \n직종을 하나 선택해주세요',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PretendardMedium',
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '나중에 관심사가 바뀌어도 수정이 가능해요',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PretendardMedium',
                        color: Colors.grey,
                      ),
                    ),
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
