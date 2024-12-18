import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/mypage/mentor_introduce/my_mentor_introduce_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyMentorIntroductionScreen extends StatelessWidget {
  const MyMentorIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyMentorIntroductionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: '멘토 자기소개',
                    subtitle: '',
                    onBackButtonPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 10),
                  Consumer<MyMentorIntroductionViewModel>(
                    builder: (context, viewModel, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 제목 필드
                          BasicTextField(
                            controller: viewModel.introController,
                            hintText: "제목",
                            currentCount: viewModel.introCharCount,
                            maxCount: 50,
                            size: BasicTextFieldSize.SMALL,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),

                          ///자기소개 입력
                          BasicTextField(
                            controller: viewModel.question1Controller,
                            hintText: '자기소개를 입력해주세요',
                            currentCount: viewModel.question1CharCount,
                            maxCount: 50,
                            size: BasicTextFieldSize.LARGE,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),

                          /// 첫 번째 질문
                          const Text(
                            '어느 분야에서 멘토링 가능하신가요?',
                            style: CogoTextStyle.body16,
                          ),
                          const SizedBox(height: 10),
                          BasicTextField(
                            controller: viewModel.question2Controller,
                            hintText: '답변을 입력해주세요',
                            currentCount: viewModel.question2CharCount,
                            maxCount: 50,
                            size: BasicTextFieldSize.LARGE,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          // 두 번째 질문
                          const Text(
                            '질문질문.... 자기소개 유도 질문...',
                            style: CogoTextStyle.body16,
                          ),
                          const SizedBox(height: 10),
                          BasicTextField(
                            controller: viewModel.question3Controller,
                            hintText: '답변을 입력해주세요',
                            currentCount: viewModel.question3CharCount,
                            maxCount: 50,
                            size: BasicTextFieldSize.LARGE,
                            maxLines: 1,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  // 저장하기 버튼
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<MyMentorIntroductionViewModel>(
                        builder: (context, viewModel, child) {
                          return ElevatedButton(
                            onPressed: viewModel.isFormValid
                                ? () => viewModel.saveIntroduction(context)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: viewModel.isFormValid
                                  ? Colors.black
                                  : Colors.grey[300],
                              foregroundColor: viewModel.isFormValid
                                  ? Colors.white
                                  : Colors.black,
                              textStyle: const TextStyle(
                                fontFamily: 'PretendardMedium',
                                fontSize: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('저장하기'),
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
