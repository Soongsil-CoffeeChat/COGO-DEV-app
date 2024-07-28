import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/view_models/shared_views/signup_phone_view_model.dart';
import 'package:cogo/common/utils/phone_number_input_formatter.dart';
import 'package:cogo/common/widgets/header.dart';

class PhoneNumberVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhoneNumberVerificationViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<PhoneNumberVerificationViewModel>(
            builder: (context, viewModel, child) {
              return Column(
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
                        padding: const EdgeInsets.only(top: 8.0),
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
                      valueListenable: viewModel.showVerificationField,
                      builder: (context, show, child) {
                        if (show) {
                          return Column(
                            children: [
                              TextField(
                                controller: viewModel.codeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: '인증번호',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
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
                  Center(
                    child: ValueListenableBuilder<bool>(
                      valueListenable: viewModel.isValidPhoneNumber,
                      builder: (context, isValid, child) {
                        return ValueListenableBuilder<bool>(
                          valueListenable: viewModel.isValidCode,
                          builder: (context, isValidCode, child) {
                            return SizedBox(
                              width: 170,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: (isValid &&
                                    (!viewModel.showVerificationField.value ||
                                        isValidCode))
                                    ? () {
                                  if (viewModel.isPhoneNumberSubmitted) {
                                    viewModel.onVerificationCodeSubmitted(context);
                                  } else {
                                    viewModel.onPhoneNumberSubmitted();
                                  }
                                }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (isValid &&
                                      (!viewModel.showVerificationField.value ||
                                          isValidCode))
                                      ? Colors.black
                                      : Colors.grey[300],
                                  foregroundColor: (isValid &&
                                      (!viewModel.showVerificationField.value ||
                                          isValidCode))
                                      ? Colors.white
                                      : Colors.black,
                                  textStyle: const TextStyle(
                                    fontFamily: 'PretendardMedium',
                                    fontSize: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(viewModel.isPhoneNumberSubmitted
                                    ? '확인'
                                    : '인증 번호 받기'),
                              ),
                            );
                          },
                        );
                      },
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
