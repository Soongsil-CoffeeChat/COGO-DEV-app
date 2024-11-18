import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';

class MultiSelectionTimePicker extends StatefulWidget {
  final DateTime selectedDay;
  final List<int> initialSelectedTimeSlots;
  final ValueChanged<int>? onTimeSlotSelected;
  final ValueChanged<int>? onTimeSlotDeselected;
  final List<String> timeSlots;

  const MultiSelectionTimePicker({
    Key? key,
    required this.selectedDay,
    required this.initialSelectedTimeSlots,
    this.onTimeSlotSelected,
    this.onTimeSlotDeselected,
    required this.timeSlots,
  }) : super(key: key);

  @override
  _MultiSelectionTimePickerState createState() =>
      _MultiSelectionTimePickerState();
}

class _MultiSelectionTimePickerState extends State<MultiSelectionTimePicker> {
  late List<int> selectedTimeSlots;

  @override
  void initState() {
    super.initState();
    // 초기 선택된 시간대 리스트 설정
    selectedTimeSlots = List.from(widget.initialSelectedTimeSlots);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10.0,
        runSpacing: 15.0,
        children: List.generate(widget.timeSlots.length, (index) {
          final isSelected = selectedTimeSlots.contains(index);

          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedTimeSlots.remove(index);
                  widget.onTimeSlotDeselected?.call(index);
                } else {
                  selectedTimeSlots.add(index);
                  widget.onTimeSlotSelected?.call(index);
                }
              });
            },
            child: Container(
              //todo timepicker로 분리
              width: 150,
              height: 35,
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
                widget.timeSlots[index],
                style: CogoTextStyle.body16.copyWith(
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
