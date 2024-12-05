import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/home/apply/schedule/schedule_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatelessWidget {
  final int mentorId;

  const ScheduleScreen({super.key, required this.mentorId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleViewModel()..fetchMentorPossibleDates(mentorId),
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
                            HorizontalDatePicker(
                              itemCount: 7,
                              selectedDate: viewModel.selectedDate,
                              onDateSelected: viewModel.onDateSelected,
                            ),
                            const Divider(
                                color: CogoColor.systemGray01, thickness: 1),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: viewModel.filteredTimeSlots.isEmpty
                                  ? Center(
                                      child: Text(
                                        '해당 날짜에는 가능한 시간대가 없어요',
                                        style: CogoTextStyle.body14.copyWith(
                                            color: CogoColor.systemGray03),
                                      ),
                                    )
                                  : SingleSelectionTimePicker(
                                      isSelectedTimePicker: false,
                                      selectedTimeSlot:
                                          viewModel.selectedTimeSlot,
                                      onTimeSlotSelected:
                                          viewModel.onTimeSlotSelected,
                                      timeSlots: viewModel.filteredTimeSlots,
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
                        child: BasicButton(
                          text: '다음',
                          isClickable: viewModel.selectedTimeSlot != -1,
                          onPressed: viewModel.selectedTimeSlot != -1
                              ? () => viewModel.saveSelection(context, mentorId)
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
