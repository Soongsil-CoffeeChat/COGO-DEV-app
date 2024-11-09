import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

class BasicButton2 extends StatelessWidget {
  final String text;
  final bool isClickable;

  /// 선택 가능한지
  final bool isSelected;

  /// 선택 되었는지
  final VoidCallback? onPressed;
  final double? width; //todo small, large

  const BasicButton2({
    Key? key,
    required this.text,
    required this.isClickable,
    required this.isSelected,
    this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: isClickable ? onPressed : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: (isClickable & isSelected)
                ? CogoColor.main
                : CogoColor.systemGray02,
            foregroundColor:
                (isClickable & isSelected) ? CogoColor.white50 : CogoColor.main,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: CogoTextStyle.body18),
        child: Text(text),
      ),
    );
  }
}
