import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/features/auth/signup/name_input/name_input_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NameInputScreen extends StatelessWidget {
  final String? phoneNumber;

  const NameInputScreen({super.key, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NameInputViewModel(
        userService: UserService(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true, // 키도브 오버 플로우 해결
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  title: '성함을 작성해 주세요',
                  subtitle: '성함은 실명으로 작성해주세요. 이후 수정이 불가능해요',
                  onBackButtonPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Consumer<NameInputViewModel>(
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
                                  return BasicButton(
                                    onPressed: isValid
                                        ? () {
                                            viewModel
                                                .setPhoneNumber(phoneNumber!);
                                            viewModel.onConfirmButtonPressed();

                                            context.push(
                                                '${Paths.agreement}/${Paths.choose}');
                                          }
                                        : null,
                                    isClickable: true,
                                    text: '확인',
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
      ),
    );
  }
}
