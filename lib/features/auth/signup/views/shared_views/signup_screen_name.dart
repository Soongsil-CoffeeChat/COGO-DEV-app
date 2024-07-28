import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/header.dart';
import 'package:cogo/features/auth/signup/view_models/shared_views/singup_name_view_model.dart';

class SignupScreenNameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupNameViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                title: '성함을 작성해 주세요',
                subtitle: '입력하신 정보는 홈 화면의 더보기에서 수정이 가능해요',
                onBackButtonPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Consumer<SignupNameViewModel>(
                  builder: (context, viewModel, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: viewModel.nameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
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
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Center(
                            child: ValueListenableBuilder<bool>(
                              valueListenable: viewModel.isValidName,
                              builder: (context, isValid, child) {
                                return SizedBox(
                                  width: 170,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: isValid
                                        ? () {
                                      viewModel.onConfirmButtonPressed(context);
                                    }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isValid
                                          ? Colors.black
                                          : Colors.grey[300],
                                      foregroundColor:
                                      isValid ? Colors.white : Colors.black,
                                      textStyle: const TextStyle(
                                        fontFamily: 'PretendardMedium',
                                        fontSize: 18,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text('확인'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}