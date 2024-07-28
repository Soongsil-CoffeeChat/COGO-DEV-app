import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/header.dart';
import 'package:cogo/features/auth/signup/view_models/mentee/completion_view_model.dart';

class MenteeCompletionScreen extends StatelessWidget {
  const MenteeCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenteeCompletionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<MenteeCompletionViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: '${viewModel.name} 멘토님! 반갑습니다.',
                    subtitle: 'COGO와 함께 커뮤니티 활성화에 동참해주셔서 고마워요\n앞으로 열혈한 활동 기대할게요!',
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
    );
  }
}
