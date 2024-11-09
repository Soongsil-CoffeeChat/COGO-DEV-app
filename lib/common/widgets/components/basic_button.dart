import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final String text;
  final bool isClickable;
  final VoidCallback? onPressed;
  final double? width; //todo small, large

  const BasicButton({
    Key? key,
    required this.text,
    required this.isClickable,
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
            backgroundColor:
                isClickable ? CogoColor.main : CogoColor.systemGray02,
            foregroundColor: isClickable ? CogoColor.white50 : CogoColor.main,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: CogoTextStyle.body18),
        child: Text(text),
      ),
    );
  }
}
