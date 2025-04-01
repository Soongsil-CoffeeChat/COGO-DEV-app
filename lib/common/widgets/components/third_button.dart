import 'package:flutter/material.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/common/widgets/atoms/texts/texts.dart';

class ThirdButton extends StatelessWidget {
  final String text;
  final bool isClickable;
  final VoidCallback? onPressed;

  const ThirdButton({
    Key? key,
    required this.text,
    this.isClickable = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isClickable ? Colors.black : Colors.white;
    final textColor = isClickable ? Colors.white : CogoColor.systemGray03;
    final borderColor = isClickable ? Colors.black : CogoColor.systemGray03;

    /// 왜 outlined button만 될까???? 뭐지???????
    return OutlinedButton(
      onPressed: isClickable ? onPressed : null,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        textStyle: CogoTextStyle.body12,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
