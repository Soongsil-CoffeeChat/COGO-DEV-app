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
  const InterestSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InterestSelectionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                    const SizedBox(height: 32.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                const double spacing = 15.0;
                                final double buttonWidth = (constraints.maxWidth - spacing) / 2;

                                return Wrap(
                                  runSpacing: 16.0,
                                  spacing: spacing,
                                  alignment: WrapAlignment.start,
                                  children: Interest.values.map((interest) {
                                    // MOBILE은 크게, 나머지는 반반
                                    final bool isMobile = interest == Interest.MOBILE;

                                    return SizedBox(
                                      // MOBILE이면 전체 너비, 아니면 절반 너비
                                      width: isMobile ? constraints.maxWidth : buttonWidth,
                                      child: SecondaryButton(
                                        text: interest.name, // Enum 이름 그대로 사용 (필요시 매핑)
                                        size: isMobile ? SBSize.LARGE : SBSize.SMALL, // 기존 로직 반영
                                        onPressed: () async {
                                          await _handleInterestSelection(
                                            context: context,
                                            viewModel: viewModel,
                                            interest: interest,
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
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

  Future<void> _handleInterestSelection({
    required BuildContext context,
    required InterestSelectionViewModel viewModel,
    required Interest interest,
  }) async {
    // 1. 관심사 로컬 저장
    await viewModel.selectInterest(interest);

    // Context 유효성 체크
    if (!context.mounted) return;

    // 2. 역할에 따른 분기
    if (viewModel.role == Role.ROLE_MENTOR.name) {
      // 멘토: 즉시 이동
      context.push('${Paths.agreement}/${Paths.mentorClub}');
    } else {
      // 멘티: 회원가입 API 호출 후 성공 시 이동
      final bool isSuccess = await viewModel.signUpMentee(interest);

      if (!context.mounted) return;

      if (isSuccess) {
        context.push('${Paths.agreement}/${Paths.completion}');
      } else {
        // 실패 시 사용자에게 알림
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('회원가입 중 오류가 발생했습니다. 다시 시도해주세요.')),
        );
      }
    }
  }
}