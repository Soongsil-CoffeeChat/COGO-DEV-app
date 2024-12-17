import 'package:cogo/common/widgets/components/basic_box.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'mentor_info_view_model.dart';

class MentorInfoScreen extends StatelessWidget {
  const MentorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MentorInfoViewModel(),
      lazy: false, // 즉시 ViewModel 초기화
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(  // SafeArea로 전체 화면을 감쌌습니다.
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<MentorInfoViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(
                      title: '멘토님의 정보를 확인해주세요',
                      subtitle: '입력하신 정보는 홈 화면의 더보기에서 수정이 가능해요',
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: BasicBox(
                                      info: viewModel.name ?? '이름',
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: BasicBox(
                                      info: viewModel.selectedInterest ?? '파트',
                                    ),
                                  ),
                                ],
                              ),
                              if (viewModel.selectedClub != 'NO CLUB') ...[
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: BasicBox(
                                        info: viewModel.selectedClub ?? '동아리',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 170,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      /// 이때 멘토 회원 가입 api를 호출함
                                      if (viewModel.isSignUpSuccessful) {
                                        context.push(
                                            '${Paths.agreement}/${Paths.completion}');
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text(viewModel.errorMessage!),
                                            action: SnackBarAction(
                                              label: 'Retry',
                                              onPressed: () {
                                                viewModel.clearError();
                                                viewModel.signUpMentor();
                                                if (viewModel
                                                    .isSignUpSuccessful) {
                                                  context.push(
                                                      '${Paths.agreement}/${Paths.completion}');
                                                }
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[300],
                                      foregroundColor: Colors.black,
                                      textStyle: const TextStyle(
                                        fontFamily: 'PretendardMedium',
                                        fontSize: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text('다음'),
                                  ),
                                ),
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
