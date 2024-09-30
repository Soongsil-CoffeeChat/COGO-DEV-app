import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:flutter/material.dart';

final class Button1 extends StatelessWidget {
  /// you can overriding text color (default : white)
  /// you also change alignment (default : TextAlign.center)
  /// you also select mode normal or inverted (default: normal)
  const Button1(
      this.data, {
        super.key,
        this.color,
        this.align = TextAlign.center,
        this.isInverted = false,
      });

  final String data;
  final Color? color;
  final TextAlign align;
  final bool isInverted;

  @override
  Widget build(BuildContext context) {
    return (isInverted?
    Text(
      data,
      style: CogoTextStyle.invertedButton1.copyWith(
        color: color,
      ),
      textAlign: align,
    )
    :
    Text(
        data,
        style: CogoTextStyle.button1.copyWith(
        color: color,
    ),
    textAlign: align,
    )
    );
  }
}

