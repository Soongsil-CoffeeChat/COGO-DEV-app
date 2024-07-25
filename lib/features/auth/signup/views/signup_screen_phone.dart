import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cogo/features/auth/signup/views_model/signup_phone_view_model.dart';
import 'package:cogo/common/utils/phone_number_input_formatter.dart';

class PhoneNumberVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhoneNumberVerificationViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<PhoneNumberVerificationViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '휴대폰 번호를 입력해주세요',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PretendardMedium',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '개인정보는 정보통신망법에 따라 안전하게 보관됩니다',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'PretendardMedium',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: viewModel.phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      PhoneNumberInputFormatter(),
                    ],
                    decoration: InputDecoration(
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
                  ValueListenableBuilder<String?>(
                    valueListenable: viewModel.errorMessage,
                    builder: (context, errorMessage, child) {
                      return errorMessage == null
                          ? SizedBox.shrink()
                          : Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: 'PretendardMedium',
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32),
                  ValueListenableBuilder<bool>(
                    valueListenable: viewModel.showVerificationField,
                    builder: (context, show, child) {
                      if (show) {
                        return Column(
                          children: [
                            TextField(
                              controller: viewModel.codeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
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
                            SizedBox(height: 32),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
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
                                  textStyle: TextStyle(
                                    fontFamily: 'PretendardMedium',
                                    fontSize: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(viewModel.isPhoneNumberSubmitted ? '확인' : '인증 번호 받기'),
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
