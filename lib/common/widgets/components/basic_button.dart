import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

/// Size enum
enum BBSize {
  SMALL,
  LARGE,
}

const double _smallWidth = 150;
const double _largeWidth = double.infinity;

class BasicButton extends StatelessWidget {
  final String text;
  final bool isClickable;
  final VoidCallback? onPressed;
  final BBSize size;

  const BasicButton({
    super.key,
    required this.text,
    required this.isClickable,
    this.onPressed,
    this.size = BBSize.SMALL, // 기본값 small
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (size == BBSize.LARGE) ? _largeWidth : _smallWidth,
      height: 50,
      child: ElevatedButton(
        onPressed: isClickable ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isClickable ? CogoColor.systemGray05 : CogoColor.systemGray02,
          foregroundColor:
              isClickable ? CogoColor.white50 : CogoColor.systemGray05,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: CogoTextStyle.body18,
        ),
        child: Text(text),
      ),
    );
  }
}
