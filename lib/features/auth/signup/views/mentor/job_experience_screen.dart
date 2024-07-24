import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/views_model/mentor/job_experience_view_model.dart';

class JobExperienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JobExperienceViewModel(),
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
          child: Consumer<JobExperienceViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '(선택) 직무와 경력을 입력해주세요',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PretendardMedium',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '입력하신 정보는 홈 화면의 더보기에서 수정이 가능해요',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'PretendardMedium',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: viewModel.positionController,
                    decoration: InputDecoration(
                      labelText: '직무(리드, 팀장 etc...)',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: viewModel.experienceController,
                    decoration: InputDecoration(
                      labelText: '경력',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 105,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.onNextPressed(context);
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Color(0xFFC1C1C1)),
                          backgroundColor: Color(0XFFF8F8F8),
                          foregroundColor: Color(0xFFC1C1C1),
                          textStyle: TextStyle(
                            fontFamily: 'PretendardMedium',
                            fontSize: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('NEXT >'),
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
