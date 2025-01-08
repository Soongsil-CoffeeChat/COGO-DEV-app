import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/mypage/my_info/my_info_view_model.dart';
import 'package:cogo/common/widgets/widgets.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({super.key});

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  late MyInfoViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MyInfoViewModel();

    // 첫 프레임이 끝난 직후, 안전하게 initialize() 호출
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                            onBackButtonPressed: () =>
                                Navigator.of(context).pop(),
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

                          /// 전화번호 필드 + 인증번호 받기 버튼
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: viewModel.phoneController,
                                  keyboardType: TextInputType.phone,
                                  style: CogoTextStyle.body18,
                                  decoration: const InputDecoration(
                                    labelText: '휴대폰 번호',
                                    labelStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (viewModel.isPhoneChanged)
                                ElevatedButton(
                                    onPressed: () {
                                      viewModel.onPhoneNumberSubmitted();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      textStyle: CogoTextStyle.body12,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text("인증번호 받기")),
                            ],
                          ),
                          const SizedBox(height: 20),

                          /// 휴대폰 인증번호 받기 클릭시 나오는 인증 번호 text field
                          if (viewModel.showVerificationField.value)
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: viewModel
                                        .phoneVerificationCodeController,
                                    keyboardType: TextInputType.number,
                                    style: CogoTextStyle.body18,
                                    decoration: const InputDecoration(
                                      labelText: '인증번호',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (viewModel.isPhoneChanged)
                                  ElevatedButton(
                                      onPressed: () {
                                        viewModel.checkPhoneVerificationCode();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        textStyle: CogoTextStyle.body12,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Text("확인")),
                              ],
                            ),
                          const SizedBox(height: 20),

                          /// 이메일 필드 + 인증번호 받기 버튼
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: viewModel.emailController,
                                  keyboardType: TextInputType.text,
                                  style: CogoTextStyle.body18,
                                  decoration: const InputDecoration(
                                    labelText: '이메일 번호',
                                    labelStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (viewModel.isEmailChanged)
                                ElevatedButton(
                                    onPressed: () {
                                      viewModel.onEmailSendButtonClicked();
                                      //TODO 이메일 인증번호
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      textStyle: CogoTextStyle.body12,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text("인증번호 받기")),
                            ],
                          ),
                          const SizedBox(height: 20),

                          /// 이메일 인증번호 받기 클릭시 나오는 인증 번호 text field
                          if (viewModel.isClickEmailSendBtn)
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: viewModel
                                        .emailVerificationCodeController,
                                    keyboardType: TextInputType.number,
                                    style: CogoTextStyle.body18,
                                    decoration: const InputDecoration(
                                      labelText: '인증번호',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                    onPressed: () {
                                      viewModel.checkEmailVerificationCode();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      textStyle: CogoTextStyle.body12,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text("확인")),
                              ],
                            ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
              ),

              /// 수정하기 버튼 (항상 아래 고정, 위에서부터 높이 10)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                child: BasicButton(
                  text: '저장하기',
                  onPressed: _viewModel.isEditable
                      ? () {
                          _viewModel.updateUserInfo();
                        }
                      : null,
                  isClickable: _viewModel.isEditable,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
