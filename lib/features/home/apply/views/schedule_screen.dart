import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/home/apply/view_models/schedule_view_model.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';

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
                            const Divider(
                                color: CogoColor.systemGray01, thickness: 1),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TimePicker(
                                selectedTimeSlot: viewModel.selectedTimeSlot,
                                onTimeSlotSelected:
                                    viewModel.onTimeSlotSelected,
                                timeSlots:
                                    viewModel.timeSlots, // 뷰모델에서 timeSlots 전달
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
                        width: double.infinity,
                        child: CustomButton(
                          text: '다음',
                          isSelected: viewModel.selectedTimeSlot != -1,
                          onPressed: viewModel.selectedTimeSlot != -1
                              ? () => viewModel.saveSelection(context)
                              : null,
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
