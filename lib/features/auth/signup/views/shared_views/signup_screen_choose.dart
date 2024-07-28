import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/view_models/shared_views/signup_choose_view_model.dart';
import 'package:cogo/common/widgets/header.dart';
import 'package:cogo/common/widgets/custom_button.dart';

class SignupScreenChoose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupChooseViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SignupChooseViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: '거의 다 되었습니다!',
                    subtitle: '멘토로 가입하실지, 멘티로 가입하실지 알려주세요',
                    onBackButtonPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              text: '멘토',
                              isSelected: viewModel.selectedRole == '멘토',
                              onPressed: () {
                                viewModel.selectRole('멘토', context);
                              },
                            ),
                            SizedBox(width: 10),
                            CustomButton(
                              text: '멘티',
                              isSelected: viewModel.selectedRole == '멘티',
                              onPressed: () {
                                viewModel.selectRole('멘티', context);
                              },
                            ),
                          ],
                        ),
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