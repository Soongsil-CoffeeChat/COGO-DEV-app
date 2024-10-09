import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/home/mentor_detail/view_models/mentor_introduction_view_model.dart';

class MentorQuestion3Screen extends StatelessWidget {
  const MentorQuestion3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MentorIntroductionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: '프로필의 자기소개를 남겨주세요',
                    subtitle: '입력하신 정보는 하단의  MY에서 수정이 가능해요',
                    onBackButtonPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 30),
                  Consumer<MentorIntroductionViewModel>(
                    builder: (context, viewModel, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '프로젝트나 근무 경험이 있으신가요?',
                            style: CogoTextStyle.body16,
                          ),
                          const SizedBox(height: 10),

                          CustomTextFieldWithCounter(
                            controller: viewModel.question3Controller,
                            hintText: '프로젝트나 근무 경험에 대해 적어주세요',
                            currentCount: viewModel.question3CharCount,
                            maxCount: 200,
                            height: 200,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 10),
                          // 첫 번째 질문
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 170),

                  Center(
                    child: SizedBox(
                      width: 170,
                      height: 50,
                      child: Consumer<MentorIntroductionViewModel>(
                        builder: (context, viewModel, child) {
                          return CustomButton(
                            text: '저장하기',
                            isSelected: viewModel.isFormValid,
                            onPressed: viewModel.isFormValid ? () => viewModel.saveIntroduction(context) : null,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
