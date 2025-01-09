import 'package:cogo/common/utils/phone_number_input_formatter.dart';
import 'package:cogo/common/widgets/components/secondary_textfield.dart';
import 'package:cogo/common/widgets/components/third_button.dart';
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
                          Header(
                            title: '코고 회원 정보',
                            subtitle: '개인정보는 정보통신망법에 따라 안전하게 보관됩니다.',
                            onBackButtonPressed: () =>
                                Navigator.of(context).pop(),
                          ),
                          const SizedBox(height: 30),

                          /// 이름 필드
                          SecondaryTextfield(
                            controller: viewModel.nameController,
                            keyboardType: TextInputType.text,
                            labelText: '이름',
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),

                          /// 전화번호 필드 + 인증번호 받기 버튼
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryTextfield(
                                  controller: viewModel.phoneController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    PhoneNumberInputFormatter(),
                                  ],
                                  labelText: '휴대폰 번호',
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (viewModel.isPhoneChanged)
                                ThirdButton(
                                  text: viewModel.isVerifyingPhone
                                      ? "재발송"
                                      : "인증번호 받기",
                                  isClickable:
                                      viewModel.validatePhoneNumber() &&
                                          viewModel.canSendPhoneVerification,
                                  onPressed: viewModel.onPhoneNumberSubmitted,
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          /// 휴대폰 인증번호 받기 클릭 시 나오는 인증 번호 text field
                          if (viewModel.showVerificationField.value)
                            Row(
                              children: [
                                Expanded(
                                  /// 휴대폰 인증 번호 text field
                                  child: SecondaryTextfield(
                                    controller: viewModel
                                        .phoneVerificationCodeController,
                                    keyboardType: TextInputType.number,
                                    labelText: '인증번호',
                                  ),
                                ),
                                const SizedBox(width: 8),

                                /// 타이머
                                Text(
                                  _formatTime(viewModel
                                      .remainingSeconds), // 남은 시간을 mm:ss 형태로 포맷
                                  style: CogoTextStyle.bodyL12
                                      .copyWith(color: Colors.red),
                                ),
                                const SizedBox(width: 8),

                                /// 확인 버튼
                                ThirdButton(
                                  onPressed: () {
                                    viewModel.checkPhoneVerificationCode();
                                    if (viewModel
                                        .successPhoneVerificationCode) {
                                      showSuccessSnackbar(
                                          context, '휴대폰 번호 인증에 성공하였습니다.');
                                    } else {
                                      showSuccessSnackbar(
                                          context, '인증번호가 일치하지 않습니다.');
                                    }
                                  },
                                  text: "확인",
                                  isClickable: true,
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),

                          /// 이메일 필드 + 인증번호 받기 버튼
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryTextfield(
                                  controller: viewModel.emailController,
                                  keyboardType: TextInputType.text,
                                  labelText: '이메일 번호',
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (viewModel.isEmailChanged)
                                ThirdButton(
                                  text: "인증번호 받기",
                                  isClickable: viewModel.isEmailChanged,
                                  onPressed: viewModel.onEmailSendButtonClicked,
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          /// 이메일 인증번호 받기 클릭 시 나오는 인증 번호 text field
                          if (viewModel.isClickEmailSendBtn)
                            Row(
                              children: [
                                Expanded(
                                  /// 이메일 인증번호 text field
                                  child: SecondaryTextfield(
                                    controller: viewModel
                                        .emailVerificationCodeController,
                                    keyboardType: TextInputType.number,
                                    labelText: '인증번호',
                                  ),
                                ),
                                const SizedBox(width: 8),

                                /// 타이머
                                Text(
                                  _formatTime(viewModel
                                      .remainingSeconds), // 남은 시간을 mm:ss 형태로 포맷
                                  style: CogoTextStyle.bodyL12
                                      .copyWith(color: Colors.red),
                                ),
                                const SizedBox(width: 8),

                                /// 확인 버튼
                                ThirdButton(
                                  onPressed: () {
                                    viewModel.checkEmailVerificationCode();
                                    if (viewModel
                                        .successEmailVerificationCode) {
                                      showSuccessSnackbar(
                                          context, '이메일 인증에 성공하였습니다.');
                                    } else {
                                      showSuccessSnackbar(
                                          context, '인증번호가 일치하지 않습니다.');
                                    }
                                  },
                                  text: "확인",
                                  isClickable: true,
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
              ),

              /// 저장하기 버튼
              /// 따로 Cusumer 구독을 해야지 상태가 변경됨 왜지???
              Consumer<MyInfoViewModel>(
                builder: (context, viewModel, child) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                    child: BasicButton(
                      text: '저장하기',
                      onPressed: viewModel.isEditable
                          ? viewModel.updateUserInfo
                          : null,
                      isClickable: viewModel.isEditable,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSuccessSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    // 예: 2:05 / 0:08 이런 식으로
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }
}
