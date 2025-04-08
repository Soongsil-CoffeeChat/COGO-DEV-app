import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';

/// 중복 선택 time picker
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
        spacing: 15.0,
        runSpacing: 15.0,
        children: List.generate(widget.timeSlots.length, (index) {
          final isSelected = selectedTimeSlots.contains(index);

          return SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 24,

            /// 화면 반절 크기
            child: GestureDetector(
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
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      isSelected ? CogoColor.systemGray01 : CogoColor.white50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? CogoColor.systemGray04
                        : CogoColor.systemGray03,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Text(
                  widget.timeSlots[index],
                  style: CogoTextStyle.body16.copyWith(
                    color: isSelected
                        ? CogoColor.systemGray04
                        : CogoColor.systemGray03,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
