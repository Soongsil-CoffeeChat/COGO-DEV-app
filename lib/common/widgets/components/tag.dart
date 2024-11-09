import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

import '../atoms/texts/styles.dart';

class Tag extends StatelessWidget {
  final String title;

  const Tag({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: CogoTextStyle.body12.copyWith(color: CogoColor.white50),
      ),
    );
  }
}
