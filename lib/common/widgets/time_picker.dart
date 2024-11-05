import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final int? selectedTimeSlot;
  final ValueChanged<int>? onTimeSlotSelected;
  final List<String> timeSlots;

  const TimePicker({
    Key? key,
    this.selectedTimeSlot, // Make selectedTimeSlot optional
    this.onTimeSlotSelected, // Make onTimeSlotSelected optional
    required this.timeSlots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10.0,
        runSpacing: 15.0,
        children: List.generate(timeSlots.length, (index) {
          final isSelected =
              selectedTimeSlot != null && index == selectedTimeSlot;

          return GestureDetector(
            onTap: onTimeSlotSelected != null
                ? () => onTimeSlotSelected!(index)
                : null,
            child: Container(
              width: 105,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: CogoColor.systemGray03,
                  width: 0.7,
                ),
              ),
              child: Text(
                timeSlots[index],
                style: CogoTextStyle.body12.copyWith(
                  color:
                      isSelected ? CogoColor.white50 : CogoColor.systemGray03,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
