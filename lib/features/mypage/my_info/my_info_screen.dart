import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/mypage/my_info/my_info_view_model.dart';
import 'package:cogo/common/widgets/widgets.dart';

class MyInfoScreen extends StatelessWidget {
  const MyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyInfoViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<MyInfoViewModel>(
              builder: (context, viewModel, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 헤더
                    Header(
                      title: '코고 회원 정보',
                      subtitle: '개인정보는 정보통신망법에 따라 안전하게 보관됩니다.',
                      onBackButtonPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 30),

                    /// 이름 필드
                    TextField(
                      controller: viewModel.nameController,
                      keyboardType: TextInputType.text,
                      style: CogoTextStyle.body18,
                      decoration: const InputDecoration(
                        labelText: '이름',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// 전화번호 필드
                    TextField(
                      controller: viewModel.phoneController,
                      keyboardType: TextInputType.phone,
                      style: CogoTextStyle.body18,
                      decoration: const InputDecoration(
                        labelText: '휴대폰 번호',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// 이메일 필드
                    TextField(
                      controller: viewModel.emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: CogoTextStyle.body18,
                      decoration: const InputDecoration(
                        labelText: '이메일 주소',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const Spacer(),

                    /// 수정하기 버튼
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Consumer<MyInfoViewModel>(
                        builder: (context, viewModel, child) {
                          return BasicButton(
                            text: '수정하기',
                            onPressed: viewModel.isEditable
                                ? () {
                                    // 수정 로직
                                    // ex) viewModel.updateUserInfo();
                                  }
                                : null, // null이면 비활성화로 처리 가능
                            isClickable: viewModel.isEditable,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
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
