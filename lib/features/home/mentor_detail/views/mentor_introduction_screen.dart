import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/home/mentor_detail/view_models/mentor_introduction_view_model.dart';

class MentorIntroductionScreen extends StatelessWidget {
  const MentorIntroductionScreen({super.key});

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
                          // 제목 필드
                          CustomTextFieldWithCounter(
                            controller: viewModel.introController,
                            hintText: '제목',
                            currentCount: viewModel.introCharCount,
                            maxCount: 50,
                            height: 50,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          //자기소개 입력
                          CustomTextFieldWithCounter(
                            controller: viewModel.question1Controller,
                            hintText: '자기소개를 입력해주세요',
                            currentCount: viewModel.question1CharCount,
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
                  const SizedBox(height: 120),

                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Consumer<MentorIntroductionViewModel>(
                        builder: (context, viewModel, child) {
                          return CustomButton(
                            text: '다음',
                            isSelected: viewModel.isFormValid,
                            onPressed: viewModel.isFormValid ? () => context.push(Paths.mentorQuestion2) : null,
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
