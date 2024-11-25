import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/components/secondary_button.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'choose_role_view_model.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isMentor = false;
    return ChangeNotifierProvider(
      create: (_) => SignupChooseViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
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
                              SecondaryButton(
                                text: '멘토',
                                onPressed: () {
                                  viewModel.selectRole(Role.MENTOR, context);
                                },
                              ),
                              SecondaryButton(
                                text: '멘티',
                                onPressed: () {
                                  viewModel.selectRole(Role.MENTEE, context);
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
      ),
    );
  }
}
