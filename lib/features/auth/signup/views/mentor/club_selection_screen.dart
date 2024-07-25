import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/custom_appbar.dart';
import 'package:cogo/features/auth/signup/views_model/mentor/club_selection_view_model.dart';

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
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildClubButton(context, 'GDSC', viewModel),
                                SizedBox(width: 10),
                                _buildClubButton(context, 'YOURSSU', viewModel),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildClubButton(context, 'UMC', viewModel),
                                SizedBox(width: 10),
                                _buildClubButton(
                                    context, 'LIKELION', viewModel),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                _buildClubButton(context, 'NO CLUB', viewModel),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 16),
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

  Widget _buildClubButton(
      BuildContext context, String club, ClubSelectionViewModel viewModel) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              viewModel.selectClub(context, club);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: viewModel.selectedClub == club
                  ? Colors.black
                  : Colors.grey[300],
              foregroundColor:
                  viewModel.selectedClub == club ? Colors.white : Colors.black,
              textStyle: const TextStyle(
                fontFamily: 'PretendardMedium',
                fontSize: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(club),
          ),
        ),
      ),
    );
  }
}
