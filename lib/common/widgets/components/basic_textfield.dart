import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';

/// Size enum
enum BasicTextFieldSize {
  SMALL,
  LARGE,
}

/// 상수 정의
const double _smallHeight = 50.0;
const double _largeHeight = 200.0;

class BasicTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int currentCount;
  final int maxCount;
  final BasicTextFieldSize size;
  final int maxLines;

  const BasicTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.currentCount,
    required this.maxCount,
    required this.size,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    // `size`에 따라 높이를 설정
    final double height =
        (size == BasicTextFieldSize.LARGE) ? _largeHeight : _smallHeight;

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
            style: CogoTextStyle.body12,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  CogoTextStyle.body12.copyWith(color: CogoColor.systemGray03),
              border: InputBorder.none,
              counterText: '',
            ),
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
