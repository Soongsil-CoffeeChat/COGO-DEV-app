import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/home/apply/view_models/schedule_view_model.dart';
import 'package:cogo/common/widgets/widgets.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Header(
                    title: '멘토님과 시간을 맞춰보세요',
                    subtitle: 'COGO를 진행하기 편한 시간대를 알려주세요.',
                    onBackButtonPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<ScheduleViewModel>(
                  builder: (context, viewModel, child) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DatePicker(
                              selectedDate: viewModel.selectedDate,
                              onDateSelected: viewModel.onDateSelected,
                            ),
                            const Divider(color: Color(0xFFE2E2E2), thickness: 1),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TimePicker(
                                selectedTimeSlot: viewModel.selectedTimeSlot,
                                onTimeSlotSelected: viewModel.onTimeSlotSelected,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<ScheduleViewModel>(
                    builder: (context, viewModel, child) {
                      return SizedBox(
                        width: double.infinity, // 버튼 너비를 화면 전체로 설정
                        height: 50, // 버튼 높이 유지
                        child: CustomButton(
                          text: '다음',
                          isSelected: viewModel.selectedTimeSlot != -1,  // 선택된 경우 true
                          onPressed: viewModel.selectedTimeSlot != -1
                              ? () => viewModel.saveSelection(context)  // 선택된 경우 동작
                              : null,  // 선택되지 않으면 비활성화
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
