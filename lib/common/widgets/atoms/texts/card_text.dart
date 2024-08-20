import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:flutter/material.dart';

final class CardHeader1 extends StatelessWidget {
  /// you can overriding text color (default : Black)
  /// you also change alignment (default : TextAlign.center)
  const CardHeader1(
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
      style: CogoTextStyle.cardHeader1.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}

final class CardHeader2 extends StatelessWidget {
  /// you can overriding text color (default : Black)
  /// you also change alignment (default : TextAlign.center)
  const CardHeader2(
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
      style: CogoTextStyle.cardHeader2.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}

final class CardCaption extends StatelessWidget {
  /// you can overriding text color (default : Black)
  /// you also change alignment (default : TextAlign.center)
  const CardCaption(
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
      style: CogoTextStyle.cardCaption.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}