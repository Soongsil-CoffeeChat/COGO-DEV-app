import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/home/mentor_detail/mentor_introduction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
                          // 제목
                          BasicTextField(
                            controller: viewModel.titleController,
                            hintText: '제목',
                            currentCount: viewModel.tittleCharCount,
                            maxCount: 50,
                            size: BasicTextFieldSize.SMALL,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          //자기소개 입력
                          BasicTextField(
                            controller: viewModel.descriptionController,
                            hintText: '내용을 입력해주세요',
                            currentCount: viewModel.descriptionCharCount,
                            maxCount: 200,
                            size: BasicTextFieldSize.LARGE,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 120),
                  Center(
                    child: SizedBox(
                      width: 170,
                      child: Consumer<MentorIntroductionViewModel>(
                        builder: (context, viewModel, child) {
                          return BasicButton(
                            text: '다음',
                            isClickable: viewModel.isFormValid,
                            onPressed: viewModel.isFormValid
                                ? () => context.push(Paths.mentorQuestion1)
                                : null,
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
