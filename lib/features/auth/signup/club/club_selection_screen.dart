import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/common/widgets/components/secondary_button.dart';
import 'package:cogo/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'club_selection_view_model.dart';

class ClubSelectionScreen extends StatelessWidget {
  const ClubSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClubSelectionViewModel(),
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
                      subtitle: '입력하신 정보는 하단의  MY에서 수정이 가능해요',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SecondaryButton(
                                      text: 'GDGoC',
                                      onPressed: () {
                                        viewModel.selectClub('GDGoC');

                                        context.push(
                                            '${Paths.agreement}/${Paths.mentorInfo}');
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: SecondaryButton(
                                      text: 'YOURSSU',
                                      onPressed: () {
                                        viewModel.selectClub('YOURSSU');
                                        context.push(
                                            '${Paths.agreement}/${Paths.mentorInfo}');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SecondaryButton(
                                      text: 'UMC',
                                      onPressed: () {
                                        viewModel.selectClub('UMC');
                                        context.push(
                                            '${Paths.agreement}/${Paths.mentorInfo}');
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: SecondaryButton(
                                      text: 'LIKELION',
                                      onPressed: () {
                                        viewModel.selectClub('LIKELION');
                                        context.push(
                                            '${Paths.agreement}/${Paths.mentorInfo}');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: SecondaryButton(
                                      text: 'NO CLUB',
                                      onPressed: () {
                                        viewModel.selectClub('NO CLUB');
                                        context.push(
                                            '${Paths.agreement}/${Paths.mentorInfo}');
                                      },
                                      size: SBSize.LARGE,
                                    ),
                                  ),
                                ],
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
