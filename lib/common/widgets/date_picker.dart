import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final DateTime date;
  final DateTime day;

  const DatePicker({
    Key? key,
    required this.date,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd');
    final dayFormat = DateFormat('E', 'ko');

    return Container(
      width: 55,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: const BoxDecoration(
        color: CogoColor.systemGray05,
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dateFormat.format(date),
            style: CogoTextStyle.body18.copyWith(
              color: CogoColor.white50,
            ),
          ),
          Text(
            dayFormat.format(date),
            style: CogoTextStyle.body9.copyWith(
              color: CogoColor.white50,
            ),
          ),
        ],
      ),
    );
  }
}
