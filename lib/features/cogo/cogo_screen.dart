import 'package:cogo/common/enums/role.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/features/cogo/cogo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cogo/common/widgets/widgets.dart';

class CogoScreen extends StatelessWidget {
  const CogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CogoViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Consumer<CogoViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        '내 코고함',
                        style: CogoTextStyle.body18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        viewModel.role == Role.ROLE_MENTOR.name
                            ? 'COGO를 하면서 많은 성장을 기원해요!'
                            : '멘토와 함께 성장하는 시간을 만들어보세요!',
                        style: CogoTextStyle.body12
                            .copyWith(color: CogoColor.systemGray03),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        ListTile(
                          title: Text(
                            viewModel.role == Role.ROLE_MENTOR.name
                                ? '받은 코고'
                                : '신청한 코고',
                            style: CogoTextStyle.body16,
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            viewModel.navigateToReceivedCogo(context);
                          },
                        ),
                        const SizedBox(height: 5),
                        const Divider(height: 0.2, color: Color(0xFFEDEDED)),
                        const SizedBox(height: 5),
                        ListTile(
                          title: const Text(
                            '성사된 코고',
                            style: CogoTextStyle.body16,
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            viewModel.navigateToSuccessedCogo(context);
                          },
                        ),
                      ],
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
