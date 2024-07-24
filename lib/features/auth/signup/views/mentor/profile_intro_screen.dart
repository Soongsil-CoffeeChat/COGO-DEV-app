import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/views_model/mentor/profile_intro_view_model.dart';

class ProfileIntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileIntroViewModel(),
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
          child: Consumer<ProfileIntroViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '프로필의 자기소개를 남겨주세요',
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
                    controller: viewModel.titleController,
                    decoration: InputDecoration(
                      labelText: '제목을 입력해주세요',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: viewModel.introController,
                    decoration: InputDecoration(
                      labelText: '자기소개 내용을 입력해주세요',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      width: 170,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.onNextPressed(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black,
                          textStyle: TextStyle(
                            fontFamily: 'PretendardMedium',
                            fontSize: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('다음'),
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
