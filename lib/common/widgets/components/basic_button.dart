import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onPressed;
  final double? width; //todo small, large

  const CustomButton({
    Key? key,
    required this.text,
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
        onPressed: isSelected ? onPressed : null,
        style: ElevatedButton.styleFrom(
            backgroundColor:
                isSelected ? CogoColor.main : CogoColor.systemGray02,
            foregroundColor: isSelected ? CogoColor.white50 : CogoColor.main,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: CogoTextStyle.body18),
        child: Text(text),
      ),
    );
  }
}
