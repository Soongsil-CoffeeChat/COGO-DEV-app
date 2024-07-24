import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/views_model/mentee/completion_view_model.dart';

class MenteeCompletionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenteeCompletionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset('assets/icons/button/back_btn.png'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<MenteeCompletionViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${viewModel.name} 멘티님! 반갑습니다.',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PretendardMedium',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'COGO와 함께 커뮤니티 활성화에 동참해주셔서 고마워요\n앞으로 열혈한 활동 기대할게요!',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'PretendardMedium',
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Image.asset(
                      'assets/icons/3d_img/3d_fire.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
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
                          textStyle: TextStyle(
                            fontFamily: 'PretendardMedium',
                            fontSize: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('코고 신청 완료하기'),
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
