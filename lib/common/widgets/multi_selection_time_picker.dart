import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';

class MultiSelectionTimePicker extends StatelessWidget {
  final Set<int> selectedTimeSlots;
  final ValueChanged<int>? onTimeSlotSelected;
  final ValueChanged<int>? onTimeSlotDeselected;
  final List<String> timeSlots;

  const MultiSelectionTimePicker({
    Key? key,
    required this.selectedTimeSlots,
    this.onTimeSlotSelected,
    this.onTimeSlotDeselected,
    required this.timeSlots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10.0,
        runSpacing: 15.0,
        children: List.generate(timeSlots.length, (index) {
          final isSelected = selectedTimeSlots.contains(index);

          return GestureDetector(
            onTap: () {
              if (isSelected) {
                onTimeSlotDeselected?.call(index);
              } else {
                onTimeSlotSelected?.call(index);
              }
            },
            child: Container(
              width: 105,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? CogoColor.systemGray05 : CogoColor.white50,
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
