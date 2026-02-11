import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/mypage/mentor_introduce/my_mentor_introduce_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyMentorIntroductionScreen extends StatelessWidget {
  const MyMentorIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          MyMentorIntroductionViewModel()..initialize(), // initialize() 호출 확인
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<MyMentorIntroductionViewModel>(
                builder: (context, viewModel, child) {
                  final state = viewModel.state;

                  if (state.isLoading) {
                    return const SizedBox(
                      height: 500, // 화면 중앙 배치를 위한 임시 높이
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('데이터를 불러오는 중 오류가 발생했습니다.',
                              style: TextStyle(color: Colors.red)),
                          const SizedBox(height: 30),
                          BasicButton(
                            text: "로그인 화면으로 돌아가기",
                            isClickable: true,
                            onPressed: () => context.push(Paths.login),
                            size: BasicButtonSize.SMALL,
                          ),
                          const SizedBox(height: 10),
                          BasicButton(
                            text: "다시 시도하기",
                            isClickable: true,
                            onPressed: () => viewModel.initialize(),
                            size: BasicButtonSize.SMALL,
                          )
                        ],
                      ),
                    );
                  }

                  // 메인 입력 폼
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        title: '멘토 자기소개',
                        subtitle: '코고에 사용될 자기소개입니다',
                        onBackButtonPressed: () {
                          FocusScope.of(context).unfocus(); // 나가기 전 포커스 해제
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(height: 20),

                      // 한 줄 소개
                      const Text('한 줄 소개', style: CogoTextStyle.body16),
                      const SizedBox(height: 10),
                      BasicTextField(
                        controller: viewModel.introController,
                        hintText: "제목",
                        currentCount: viewModel.introCharCount,
                        maxCount: 50,
                        size: BasicTextFieldSize.SMALL,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 30),

                      // 자기소개 상세
                      const Text('간단하게 자기소개 부탁드려요',
                          style: CogoTextStyle.body16),
                      const SizedBox(height: 10),
                      BasicTextField(
                        controller: viewModel.descriptionController,
                        hintText: '내용을 입력해주세요.',
                        currentCount: viewModel.descriptionCount,
                        maxCount: 100,
                        size: BasicTextFieldSize.LARGE,
                        maxLines: 3, // 내용 입력을 위해 줄 수 늘림 권장
                      ),
                      const SizedBox(height: 30),

                      // 질문 1
                      const Text('멘토링하실 분야에 대해 자세히 알려주세요',
                          style: CogoTextStyle.body16),
                      const SizedBox(height: 10),
                      BasicTextField(
                        controller: viewModel.question1Controller,
                        hintText: '답변을 입력해주세요',
                        currentCount: viewModel.question1CharCount,
                        maxCount: 300,
                        size: BasicTextFieldSize.LARGE,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 30),

                      // 질문 2
                      const Text('프로젝트나 근무 경험이 있으시다면 알려주세요',
                          style: CogoTextStyle.body16),
                      const SizedBox(height: 10),
                      BasicTextField(
                        controller: viewModel.question2Controller,
                        hintText: '답변을 입력해주세요',
                        currentCount: viewModel.question2CharCount,
                        maxCount: 300,
                        size: BasicTextFieldSize.LARGE,
                        maxLines: 3,
                      ),

                      const SizedBox(height: 40),

                      // 저장하기 버튼: Center 위젯으로 감싸서 중앙 정렬
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: BasicButton(
                            text: '저장하기',
                            isClickable: viewModel.isFormValid,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              bool isSaved = await viewModel.saveIntroduction();
                              if (isSaved) {
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('자기소개 저장이 실패하였습니다.')),
                                );
                              }
                            },
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
      ),
    );
  }
}
