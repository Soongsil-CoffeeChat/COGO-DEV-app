import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/signup_custom_appbar.dart';
import 'package:cogo/features/auth/signup/views_model/mentor/club_selection_view_model.dart';
import 'package:cogo/common/widgets/signup_custom_button.dart';

class ClubSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClubSelectionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ClubSelectionViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '소속된 동아리가 있나요?',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PretendardMedium',
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '입력하신 정보는 홈 화면의 더보기에서 수정이 가능해요',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PretendardMedium',
                        color: Colors.grey,
                      ),
                    ),
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
                                CustomButton(
                                  text: 'GDSC',
                                  isSelected: viewModel.selectedClub == 'GDSC',
                                  onPressed: () {
                                    viewModel.selectClub(context, 'GDSC');
                                  },
                                ),
                                const SizedBox(width: 10),
                                CustomButton(
                                  text: 'YOURSSU',
                                  isSelected: viewModel.selectedClub == 'YOURSSU',
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
                                CustomButton(
                                  text: 'UMC',
                                  isSelected: viewModel.selectedClub == 'UMC',
                                  onPressed: () {
                                    viewModel.selectClub(context, 'UMC');
                                  },
                                ),
                                const SizedBox(width: 10),
                                CustomButton(
                                  text: 'LIKELION',
                                  isSelected: viewModel.selectedClub == 'LIKELION',
                                  onPressed: () {
                                    viewModel.selectClub(context, 'LIKELION');
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                CustomButton(
                                  text: 'NO CLUB',
                                  isSelected: viewModel.selectedClub == 'NO CLUB',
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
    );
  }
}
