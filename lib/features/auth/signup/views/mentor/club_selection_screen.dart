import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/views_model/mentor/club_selection_view_model.dart';

class ClubSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClubSelectionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset('assets/icons/button/back_btn.png'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ClubSelectionViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '(선택) 소속된 동아리가 있나요?',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PretendardMedium',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '입력하신 정보는 홈 화면의 더보기에서 수정이 가능해요',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'PretendardMedium',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
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
                              _buildClubButton(context, 'LIKELION', viewModel),
                            ],
                          ),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 105,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  viewModel.skipSelection(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Color(0xFFC1C1C1)),
                                  backgroundColor: Color(0XFFF8F8F8),
                                  foregroundColor: Color(0xFFC1C1C1),
                                  textStyle: TextStyle(
                                    fontFamily: 'PretendardMedium',
                                    fontSize: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text('SKIP >'),
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildClubButton(BuildContext context, String club, ClubSelectionViewModel viewModel) {
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
              backgroundColor: viewModel.selectedClub == club ? Colors.black : Colors.grey[300],
              foregroundColor: viewModel.selectedClub == club ? Colors.white : Colors.black,
              textStyle: TextStyle(
                fontFamily: 'PretendardMedium',
                fontSize: 16,
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
