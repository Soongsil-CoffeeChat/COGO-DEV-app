import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/header.dart';
import 'package:cogo/features/home/apply/view_models/schedule_view_model.dart';

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
              mainAxisSize: MainAxisSize.min,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Consumer<ScheduleViewModel>(
                      builder: (context, viewModel, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildDateSelector(viewModel),
                            const Divider(
                              color: Color(0xFFE2E2E2),
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _buildTimeSlots(viewModel),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                _buildNextButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(ScheduleViewModel viewModel) {
    final now = DateTime.now();
    final dateFormat = DateFormat('dd');
    final dayFormat = DateFormat('E', 'ko');

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = now.add(Duration(days: index));
          final isSelected = date.day == viewModel.selectedDate.day;

          return GestureDetector(
            onTap: () => viewModel.onDateSelected(date),
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : const Color(0xFFEDEDED),
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dateFormat.format(date),
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PretendardMedium',
                      color: isSelected ? Colors.white : const Color(0xFF6E6E6E),
                    ),
                  ),
                  Text(
                    dayFormat.format(date),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'PretendardMedium',
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSlots(ScheduleViewModel viewModel) {
    final timeSlots = [
      '09:00 ~ 10:00',
      '10:00 ~ 11:00',
      '11:00 ~ 12:00',
      '13:00 ~ 14:00',
      '14:00 ~ 15:00',
      '15:00 ~ 16:00',
    ];

    return Wrap(
      spacing: 8.0,
      runSpacing: 15.0,
      children: List.generate(timeSlots.length, (index) {
        final isSelected = index == viewModel.selectedTimeSlot;

        return GestureDetector(
          onTap: () => viewModel.onTimeSlotSelected(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFE2E2E2),
                width: 1.0,
              ),
            ),
            child: Text(
              timeSlots[index],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontFamily: 'PretendardMedium',
                fontSize: 12,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Consumer<ScheduleViewModel>(
            builder: (context, viewModel, child) {
              return ElevatedButton(
                onPressed: viewModel.selectedTimeSlot != -1 ? () => viewModel.saveSelection(context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: viewModel.selectedTimeSlot != -1 ? Colors.black : Colors.grey[300],
                  foregroundColor: viewModel.selectedTimeSlot != -1 ? Colors.white : Colors.black,
                  textStyle: const TextStyle(
                    fontFamily: 'PretendardMedium',
                    fontSize: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('다음'),
              );
            },
          ),
        ),
      ),
    );
  }
}
