import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:flutter/material.dart';

final class Caption1 extends StatelessWidget {
  /// you can overriding text color (default : grey)
  /// you also change alignment (default : TextAlign.center)
  const Caption1(
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
      style: CogoTextStyle.caption1.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}

final class Caption2 extends StatelessWidget {
  /// you can overriding text color (default : grey)
  /// you also change alignment (default : TextAlign.center)
  const Caption2(
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
      style: CogoTextStyle.caption2.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}

final class Caption3 extends StatelessWidget {
  /// you can overriding text color (default : grey)
  /// you also change alignment (default : TextAlign.center)
  const Caption3(
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
      style: CogoTextStyle.caption3.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}