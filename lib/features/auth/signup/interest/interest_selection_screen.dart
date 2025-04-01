import 'package:cogo/common/enums/interest.dart';
import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/common/widgets/components/secondary_button.dart';
import 'package:cogo/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'interest_selection_view_model.dart';

class InterestSelectionScreen extends StatelessWidget {
  const InterestSelectionScreen({super.key, Role? role});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InterestSelectionViewModel(),
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
                                  Expanded(
                                    child: SecondaryButton(
                                      text: 'FE',
                                      onPressed: () {
                                        handleButtonPress(
                                          context: context,
                                          role: viewModel.role,
                                          interest: Interest.FE,
                                          isSignSuccess:
                                              viewModel.isMenteeSignSuccess,
                                          onSelectInterest: (interest) =>
                                              viewModel
                                                  .selectInterest(interest),
                                          onSignUpMentee: (interest) =>
                                              viewModel.signUpMentee(interest),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: SecondaryButton(
                                      text: 'BE',
                                      // viewModel.selectedInterest == 'BE',
                                      onPressed: () {
                                        handleButtonPress(
                                          context: context,
                                          role: viewModel.role,
                                          interest: Interest.BE,
                                          isSignSuccess:
                                              viewModel.isMenteeSignSuccess,
                                          onSelectInterest: (interest) =>
                                              viewModel
                                                  .selectInterest(interest),
                                          onSignUpMentee: (interest) =>
                                              viewModel.signUpMentee(interest),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SecondaryButton(
                                      text: 'PM',
                                      onPressed: () {
                                        handleButtonPress(
                                          context: context,
                                          role: viewModel.role,
                                          interest: Interest.PM,
                                          isSignSuccess:
                                              viewModel.isMenteeSignSuccess,
                                          onSelectInterest: (interest) =>
                                              viewModel
                                                  .selectInterest(interest),
                                          onSignUpMentee: (interest) =>
                                              viewModel.signUpMentee(interest),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: SecondaryButton(
                                      text: 'DESIGN',
                                      // viewModel.selectedInterest == '디자인',
                                      onPressed: () {
                                        handleButtonPress(
                                          context: context,
                                          role: viewModel.role,
                                          interest: Interest.DESIGN,
                                          isSignSuccess:
                                              viewModel.isMenteeSignSuccess,
                                          onSelectInterest: (interest) =>
                                              viewModel
                                                  .selectInterest(interest),
                                          onSignUpMentee: (interest) =>
                                              viewModel.signUpMentee(interest),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: SecondaryButton(
                                      text: 'MOBILE',
                                      // viewModel.selectedInterest == '디자인',
                                      onPressed: () {
                                        handleButtonPress(
                                          context: context,
                                          role: viewModel.role,
                                          interest: Interest.MOBILE,
                                          isSignSuccess:
                                              viewModel.isMenteeSignSuccess,
                                          onSelectInterest: (interest) =>
                                              viewModel
                                                  .selectInterest(interest),
                                          onSignUpMentee: (interest) =>
                                              viewModel.signUpMentee(interest),
                                        );
                                      },
                                      size: SBSize.LARGE,
                                    ),
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

  void handleButtonPress({
    required BuildContext context,
    required String? role,
    required Interest interest,
    required bool isSignSuccess,
    required void Function(Interest) onSelectInterest,
    required void Function(Interest) onSignUpMentee,
  }) {
    onSelectInterest(interest);

    if (role == Role.ROLE_MENTOR.name) {
      context.push('${Paths.agreement}/${Paths.mentorClub}');
    } else {
      onSignUpMentee(interest);

      if (isSignSuccess) {
        context.push('${Paths.agreement}/${Paths.completion}');
      }
    }
  }
}
