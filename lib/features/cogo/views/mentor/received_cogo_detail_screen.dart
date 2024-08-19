import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/header.dart';
import 'package:cogo/common/widgets/custom_button.dart';
import 'package:cogo/features/cogo/view_models/mentor/received_cogo_detail_view_model.dart';

class ReceivedCogoDetailScreen extends StatelessWidget {
  const ReceivedCogoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReceivedCogoDetailViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Header(
                            title: '김지은님이 코고신청을 보냈어요',
                            subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
                            onBackButtonPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 0,
                              maxWidth: double.infinity,
                            ),
                            child: IntrinsicWidth(
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  '안녕하세요, 저는 코고 개발자 김지은입니다. 다름이 아니라, 어쩌구저쩌구',
                                  style: TextStyle(
                                    fontFamily: 'PretendardMedium',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildDateBox(context, '7/31'),
                              _buildDateBox(context, '8/3'),
                              _buildDateBox(context, '9/9'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                          child: Consumer<ReceivedCogoDetailViewModel>(
                            builder: (context, viewModel, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildTimeSlotButton(context, '09:00 ~ 10:00', 0, viewModel),
                                  _buildTimeSlotButton(context, '10:00 ~ 11:00', 1, viewModel),
                                  _buildTimeSlotButton(context, '11:00 ~ 12:00', 2, viewModel),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<ReceivedCogoDetailViewModel>(
                  builder: (context, viewModel, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: '거절',
                          isSelected: false,
                          onPressed: () {
                            viewModel.reject(context);
                          },
                        ),
                        CustomButton(
                          text: '수락',
                          isSelected: viewModel.isAcceptSelected,
                          onPressed: viewModel.isAcceptSelected
                              ? () {
                            viewModel.accept(context);
                          }
                              : () {}, // 여기서 빈 함수 전달
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateBox(BuildContext context, String date) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            date,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'PretendardMedium',
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlotButton(
      BuildContext context, String text, int index, ReceivedCogoDetailViewModel viewModel) {
    final bool isSelected = index == viewModel.selectedTimeSlotIndex;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              viewModel.selectTimeSlot(index);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 0),
              backgroundColor: isSelected ? Colors.black : Colors.white,
              foregroundColor: isSelected ? Colors.white : const Color(0xFF8F8F8F),
              elevation: 0,
              textStyle: const TextStyle(
                fontFamily: 'PretendardMedium',
                fontSize: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.grey),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF8F8F8F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
