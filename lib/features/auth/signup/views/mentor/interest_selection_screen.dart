import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/custom_appbar.dart';
import 'package:cogo/features/auth/signup/views_model/mentor/interest_selection_view_model.dart';

class InterestSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InterestSelectionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<InterestSelectionViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '나의 관심사 또는 희망하는 \n직종을 하나 선택해주세요',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PretendardMedium',
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '나중에 관심사가 바뀌어도 수정이 가능해요',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PretendardMedium',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInterestButton(context, 'FE', viewModel),
                                SizedBox(width: 10),
                                _buildInterestButton(context, 'BE', viewModel),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInterestButton(context, '기획', viewModel),
                                SizedBox(width: 10),
                                _buildInterestButton(context, '디자인', viewModel),
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
    );
  }

  Widget _buildInterestButton(BuildContext context, String interest,
      InterestSelectionViewModel viewModel) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              viewModel.selectInterest(context, interest);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: viewModel.selectedInterest == interest
                  ? Colors.black
                  : Colors.grey[300],
              foregroundColor: viewModel.selectedInterest == interest
                  ? Colors.white
                  : Colors.black,
              textStyle: const TextStyle(
                fontFamily: 'PretendardMedium',
                fontSize: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(interest),
          ),
        ),
      ),
    );
  }
}
