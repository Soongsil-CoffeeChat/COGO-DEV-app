import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/views_model/mentor/mentor_info_view_model.dart';

class MentorInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MentorInfoViewModel(),
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
          child: Consumer<MentorInfoViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '멘토님의 정보를 확인해주세요',
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
                              _buildInfoBox(context, viewModel.name ?? '나는 교회', viewModel),
                              SizedBox(width: 10),
                              _buildInfoBox(context, viewModel.selectedInterst ?? 'BE', viewModel),
                            ],
                          ),
                          if (viewModel.selectedClub != null) ...[
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoBox(context, viewModel.selectedClub ?? 'YOURSSU', viewModel),
                                SizedBox(width: 10),
                                _buildInfoBox(context, viewModel.selectedJob ?? '직무직무', viewModel),
                                SizedBox(width: 10),
                                _buildInfoBox(context, viewModel.selectedExperience ?? '경력', viewModel),
                              ],
                            ),
                          ],
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 170,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  viewModel.nextPage(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  foregroundColor: Colors.black,
                                  textStyle: TextStyle(
                                    fontFamily: 'PretendardMedium',
                                    fontSize: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text('다음'),
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

  Widget _buildInfoBox(BuildContext context, String info, MentorInfoViewModel viewModel) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            info,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'PretendardMedium',
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}