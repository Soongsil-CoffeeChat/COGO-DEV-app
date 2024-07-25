import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cogo/features/auth/signup/views_model/singup_name_view_model.dart';

class SignupScreenNameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupNameViewModel(),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '성함을 작성해 주세요',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'PretendardMedium',
                ),
              ),
              SizedBox(height: 8),
              Text(
                '입력하신 정보는 홈 화면의  더보기에서 수정이 가능해요',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'PretendardMedium',
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24),
              Consumer<SignupNameViewModel>(
                builder: (context, viewModel, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: viewModel.nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: '성함',
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
                      Center(
                        child: ValueListenableBuilder<bool>(
                          valueListenable: viewModel.isValidName,
                          builder: (context, isValid, child) {
                            return SizedBox(
                              width: 170,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: isValid
                                    ? () {
                                  context.go('/agreement/phone/name/choose');
                                }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isValid ? Colors.black : Colors.grey[300],
                                  foregroundColor: isValid ? Colors.white : Colors.black,
                                  textStyle: TextStyle(
                                    fontFamily: 'PretendardMedium',
                                    fontSize: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text('확인'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
