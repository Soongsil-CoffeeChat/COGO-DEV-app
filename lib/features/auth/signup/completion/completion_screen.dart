import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/features/auth/signup/view_models/shared_views/completion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CompletionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<CompletionViewModel>(
              builder: (context, viewModel, child) {
                // role이 "멘토"인지 "멘티"인지에 따라 다른 텍스트를 출력
                String greetingText =
                    viewModel.role == "mentor" ? "멘토님! 반갑습니다."
                    : "멘티님! 반갑습니다.";

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(
                      title: '$greetingText',
                      subtitle:
                      'COGO와 함께 커뮤니티 활성화에 동참해주셔서 고마워요\n앞으로 열혈한 활동 기대할게요!',
                      onBackButtonPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/3d_img/3d_fire.png',
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            viewModel.completeApplication(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontFamily: 'PretendardMedium',
                              fontSize: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('코고 가입 완료하기'),
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
