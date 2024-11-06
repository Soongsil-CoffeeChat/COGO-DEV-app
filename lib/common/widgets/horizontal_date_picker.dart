import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final int itemCount;

  const HorizontalDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    bool addedExtraContainer = false;

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final date = now.add(Duration(days: index));
          final isSelected = date.day == selectedDate.day;

          final isLastDayOfMonth =
              date.month != date.add(const Duration(days: 1)).month;

          if (isLastDayOfMonth && !addedExtraContainer) {
            addedExtraContainer = true;
            return Row(
              children: [
                _buildDateContainer(date, isSelected, isLastDayOfMonth, index),
                _buildNewContainer(date),
              ],
            );
          }

          return _buildDateContainer(date, isSelected, isLastDayOfMonth, index);
        },
      ),
    );
  }

  Widget _buildDateContainer(
      DateTime date, bool isSelected, bool isLastDayOfMonth, int index) {
    final dateFormat = DateFormat('dd');
    final dayFormat = DateFormat('E', 'ko');

    return GestureDetector(
      onTap: () => onDateSelected(date),
      child: Container(
        width: 55,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: isSelected ? CogoColor.systemGray05 : CogoColor.systemGray02,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dateFormat.format(date),
              style: CogoTextStyle.body18.copyWith(
                color: isSelected ? CogoColor.white50 : CogoColor.systemGray04,
              ),
            ),
            Text(
              index == 0 ? '오늘' : dayFormat.format(date),
              style: CogoTextStyle.body9.copyWith(
                color: isSelected ? CogoColor.white50 : CogoColor.systemGray05,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewContainer(DateTime date) {
    final yearFormat = DateFormat('yyyy');
    final monthFormat = DateFormat('M월');
    final nextMonthDate = DateTime(date.year, date.month + 1, 1);

    return Container(
      width: 55,
      decoration: BoxDecoration(
        color: CogoColor.white50,
        shape: BoxShape.circle,
        border: Border.all(color: CogoColor.systemGray03, width: 0.7),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              yearFormat.format(date),
              style: CogoTextStyle.body9.copyWith(
                color: CogoColor.systemGray03,
              ),
            ),
            Text(
              monthFormat.format(nextMonthDate),
              style: CogoTextStyle.body14.copyWith(
                color: CogoColor.systemGray03,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
