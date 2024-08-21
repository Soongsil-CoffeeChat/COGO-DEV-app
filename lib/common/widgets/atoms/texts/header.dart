import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:flutter/material.dart';

final class Header1 extends StatelessWidget {
  /// you can overriding text color (default : Black)
  /// you also change alignment (default : TextAlign.center)
  const Header1(
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
      style: CogoTextStyle.header1.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}

final class Header2 extends StatelessWidget {
  /// you can overriding text color (default : Black)
  /// you also change alignment (default : TextAlign.center)
  const Header2(
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
      style: CogoTextStyle.header2.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}

final class Header3 extends StatelessWidget {
  /// you can overriding text color (default : Black)
  /// you also change alignment (default : TextAlign.center)
  const Header3(
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
      style: CogoTextStyle.header3.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}