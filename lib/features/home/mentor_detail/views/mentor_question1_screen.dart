import 'package:cogo/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/home/mentor_detail/view_models/mentor_introduction_view_model.dart';

class MentorQuestion1Screen extends StatelessWidget {
  const MentorQuestion1Screen({super.key});

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
                            '어느 분야에서 멘토링 가능하신가요?',
                            style: CogoTextStyle.body16,
                          ),
                          const SizedBox(height: 10),

                          CustomTextFieldWithCounter(
                            controller: viewModel.answer1Controller,
                            hintText: '멘토링 가능한 분야를 적어주세요',
                            currentCount: viewModel.answer1CharCount,
                            maxCount: 200,
                            height: 200,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 10),
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
