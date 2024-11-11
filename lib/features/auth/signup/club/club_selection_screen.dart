import 'package:cogo/common/widgets/components/basic_button.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'club_selection_view_model.dart';

class ClubSelectionScreen extends StatelessWidget {
  const ClubSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClubSelectionViewModel(userService: UserService()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<ClubSelectionViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(
                      title: '소속된 동아리가 있나요?',
                      subtitle: '입력하신 정보는 홈 화면의 더보기에서 수정이 가능해요',
                      onBackButtonPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BasicButton(
                                    text: 'GDSC',
                                    isClickable: true,
                                    // viewModel.selectedClub == 'GDSC',
                                    onPressed: () {
                                      viewModel.selectClub(context, 'GDSC');
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  BasicButton(
                                    text: 'YOURSSU',
                                    isClickable: true,
                                    // viewModel.selectedClub == 'YOURSSU',
                                    onPressed: () {
                                      viewModel.selectClub(context, 'YOURSSU');
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BasicButton(
                                    text: 'UMC',
                                    isClickable: true,
                                    // viewModel.selectedClub == 'UMC',
                                    onPressed: () {
                                      viewModel.selectClub(context, 'UMC');
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  BasicButton(
                                    text: 'LIKELION',
                                    isClickable: true,
                                    // viewModel.selectedClub == 'LIKELION',
                                    onPressed: () {
                                      viewModel.selectClub(context, 'LIKELION');
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  BasicButton(
                                    text: 'NO CLUB',
                                    isClickable: true,
                                    // viewModel.selectedClub == 'NO CLUB',
                                    onPressed: () {
                                      viewModel.selectClub(context, 'NO CLUB');
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 16),
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
