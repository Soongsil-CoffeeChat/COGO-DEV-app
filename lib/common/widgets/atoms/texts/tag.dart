import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:flutter/material.dart';

final class TagText extends StatelessWidget {
  /// you can overriding text color (default : Black)
  /// you also change alignment (default : TextAlign.center)
  const TagText(
      this.data, {
        super.key,
        this.color,
        this.align = TextAlign.center,
      });

  final String data;
  final Color? color;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: CogoTextStyle.tagText.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}