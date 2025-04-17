import 'package:cogo/common/utils/phone_number_input_formatter.dart';
import 'package:cogo/common/widgets/components/basic_button.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/features/auth/signup/phone_number/phone_number_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhoneNumberViewModel(
        userService: UserService(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Consumer<PhoneNumberViewModel>(
            builder: (context, viewModel, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Header(
                              title: '휴대폰 번호를 입력해주세요',
                              subtitle: '개인정보는 정보통신망법에 따라 안전하게 보관됩니다',
                              onBackButtonPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: TextField(
                                controller: viewModel.phoneController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  PhoneNumberInputFormatter(),
                                ],
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
                            ),
                            ValueListenableBuilder<String?>(
                              valueListenable: viewModel.errorMessage,
                              builder: (context, errorMessage, child) {
                                return errorMessage == null
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          errorMessage,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontFamily: 'PretendardMedium',
                                          ),
                                        ),
                                      );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 34.0),
                              child: ValueListenableBuilder<bool>(
                                valueListenable:
                                    viewModel.showVerificationField,
                                builder: (context, show, child) {
                                  if (show) {
                                    return Column(
                                      children: [
                                        TextField(
                                          controller: viewModel.codeController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: '인증번호',
                                            labelStyle:
                                                TextStyle(color: Colors.grey),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                      ],
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            const Spacer(), // 버튼을 아래로 밀기 위해 추가
                            Center(
                              child: ValueListenableBuilder<bool>(
                                valueListenable: viewModel.isValidPhoneNumber,
                                builder: (context, isValid, child) {
                                  return ValueListenableBuilder<bool>(
                                    valueListenable: viewModel.isValidCode,
                                    builder: (context, isValidCode, child) {
                                      return BasicButton(
                                        text: viewModel.isPhoneNumberSubmitted
                                            ? '확인'
                                            : '인증 번호 받기',
                                        isClickable: isValid &&
                                            (!viewModel.showVerificationField
                                                    .value ||
                                                isValidCode),
                                        onPressed: (isValid &&
                                                (!viewModel
                                                        .showVerificationField
                                                        .value ||
                                                    isValidCode))
                                            ? () {
                                                if (viewModel
                                                    .isPhoneNumberSubmitted) {
                                                  viewModel
                                                      .onVerificationCodeSubmitted(
                                                          context);
                                                } else {
                                                  viewModel
                                                      .onPhoneNumberSubmitted();
                                                }
                                              }
                                            : null,
                                        size: BasicButtonSize.SMALL,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
