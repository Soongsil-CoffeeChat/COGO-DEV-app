import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final int selectedTimeSlot;
  final ValueChanged<int> onTimeSlotSelected;

  const TimePicker({
    Key? key,
    required this.selectedTimeSlot,
    required this.onTimeSlotSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        final isSelected = index == selectedTimeSlot;

        return GestureDetector(
          onTap: () => onTimeSlotSelected(index),
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
}
