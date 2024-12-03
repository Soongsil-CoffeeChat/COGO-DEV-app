import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/mypage/mentor_introduce/mentor_introduce_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MentorIntroductionScreen extends StatelessWidget {
  const MentorIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MentorIntroductionViewModel(),
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
                  Consumer<MentorIntroductionViewModel>(
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
                            size: BTSize.SMALL,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),

                          ///자기소개 입력
                          BasicTextField(
                            controller: viewModel.question1Controller,
                            hintText: '자기소개를 입력해주세요',
                            currentCount: viewModel.question1CharCount,
                            maxCount: 50,
                            size: BTSize.LARGE,
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
                            size: BTSize.LARGE,
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
                            size: BTSize.LARGE,
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
                      child: Consumer<MentorIntroductionViewModel>(
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

  /// widgets -> components -> basic textfield로 바꾸시면 됩니다
// 제목 필드를 따로 만드는 헬퍼 메서드
// Widget _buildTitleTextField(MentorIntroductionViewModel viewModel,
//     String hintText, TextEditingController controller) {
//   return Container(
//     height: 50,
//     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//     decoration: BoxDecoration(
//       color: const Color(0xFFF7F7F7),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: TextField(
//       controller: controller,
//       maxLength: 50,
//       maxLines: 1, // 한 줄로만 표현
//       decoration: InputDecoration(
//         hintText: hintText,
//         // hintStyle: CogoTextStyle.unselectedText2,
//         border: InputBorder.none,
//         counterText: '', // 기본 카운터 숨기기
//       ),
//       onChanged: (text) {
//         viewModel.updateCharCount(controller); // 글자 수 업데이트
//       },
//     ),
//   );
// }

// 일반 TextField와 글자 수 카운터를 표시하는 헬퍼 메서드
// Widget _buildTextFieldWithCounter(
//     MentorIntroductionViewModel viewModel,
//     String hintText,
//     TextEditingController controller,
//     int currentCount,
//     int maxCount) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.end,
//     children: [
//       Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: const Color(0xFFF7F7F7),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: TextField(
//           controller: controller,
//           maxLength: maxCount,
//           maxLines: 5, // 여러 줄 입력 가능
//           decoration: InputDecoration(
//             hintText: hintText,
//             // hintStyle: CogoTextStyle.unselectedText2,
//             border: InputBorder.none,
//             counterText: '', // 기본 카운터 숨기기
//           ),
//           onChanged: (text) {
//             viewModel.updateCharCount(controller); // 글자 수 업데이트
//           },
//         ),
//       ),
//       const SizedBox(height: 5),
//       Text(
//         '$currentCount/$maxCount', // 실시간으로 글자 수를 표시
//         // style: CogoTextStyle.unselectedText2,
//       ),
//     ],
//   );
// }
}
