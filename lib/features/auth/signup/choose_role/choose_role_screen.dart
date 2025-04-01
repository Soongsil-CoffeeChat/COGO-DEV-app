import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/common/widgets/components/secondary_button.dart';
import 'package:cogo/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'choose_role_view_model.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChooseRoleViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<ChooseRoleViewModel>(
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
                              Expanded(
                                child: SecondaryButton(
                                  text: '멘토',
                                  onPressed: () {
                                    viewModel.selectRole(Role.ROLE_MENTOR);
                                    context.push(
                                        '${Paths.agreement}/${Paths.interest}');
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: SecondaryButton(
                                  text: '멘티',
                                  onPressed: () {
                                    viewModel.selectRole(Role.ROLE_MENTEE);
                                    context.push(
                                        '${Paths.agreement}/${Paths.interest}');
                                  },
                                ),
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
