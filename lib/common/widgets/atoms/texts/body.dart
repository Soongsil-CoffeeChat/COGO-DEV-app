import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:flutter/material.dart';

final class Body1 extends StatelessWidget {
  /// you can overriding text color (default : Black)
  /// you also change alignment (default : TextAlign.center)
  const Body1(
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
      style: CogoTextStyle.body1.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}

final class BodyCaption1 extends StatelessWidget {
  /// you can overriding text color (default : Black)
  /// you also change alignment (default : TextAlign.center)
  const BodyCaption1(
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
      style: CogoTextStyle.bodyCaption1.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}