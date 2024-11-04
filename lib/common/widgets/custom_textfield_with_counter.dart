import 'package:flutter/material.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/common/widgets/widgets.dart';

class CustomTextFieldWithCounter extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int currentCount;
  final int maxCount;
  final double height;
  final int maxLines;

  const CustomTextFieldWithCounter({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.currentCount,
    required this.maxCount,
    required this.height,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: height,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: CogoColor.systemGray01,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            maxLength: maxCount,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: CogoTextStyle.body12,
              border: InputBorder.none,
              counterText: '',
            ),
            onChanged: (text) => {},  // ViewModel로부터 분리됨
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '$currentCount/$maxCount',
          style: CogoTextStyle.body12.copyWith(color: CogoColor.systemGray03),
        ),
      ],
    );
  }
}
