import 'package:cogo/common/enums/interest.dart';
import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/components/basic_button.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/common/widgets/components/secondary_button.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'interest_selection_view_model.dart';

class InterestSelectionScreen extends StatelessWidget {
  const InterestSelectionScreen({super.key, Role? role});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InterestSelectionViewModel(userService: UserService()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          // SafeArea로 전체 화면을 감쌌습니다.
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SecondaryButton(
                                    text: 'FE',
                                    // viewModel.selectedInterest == 'FE',
                                    onPressed: () {
                                      viewModel.selectInterest(
                                          context, Interest.FE);
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  SecondaryButton(
                                    text: 'BE',
                                    // viewModel.selectedInterest == 'BE',
                                    onPressed: () {
                                      viewModel.selectInterest(
                                          context, Interest.BE);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SecondaryButton(
                                    text: 'PM',
                                    onPressed: () {
                                      viewModel.selectInterest(
                                          context, Interest.PM);
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  SecondaryButton(
                                    text: 'DESIGN',
                                    // viewModel.selectedInterest == '디자인',
                                    onPressed: () {
                                      viewModel.selectInterest(
                                          context, Interest.DESIGN);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  SecondaryButton(
                                    text: 'MOBILE',
                                    // viewModel.selectedInterest == '디자인',
                                    onPressed: () {
                                      viewModel.selectInterest(
                                          context, Interest.MOBILE);
                                    },
                                    width: 'large',
                                  ),
                                  const SizedBox(width: 10),
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
