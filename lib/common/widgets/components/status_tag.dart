import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

import '../atoms/texts/styles.dart';

class StatusTag extends StatelessWidget {
  final bool status;

  const StatusTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: status ? Colors.black : Colors.white,
        border:
            Border.all(color: status ? Colors.black : CogoColor.systemGray03),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status ? "수락" : "거절",
        style: status
            ? CogoTextStyle.body12.copyWith(color: CogoColor.white50)
            : CogoTextStyle.body12.copyWith(color: CogoColor.systemGray03),
      ),
    );
  }
}
