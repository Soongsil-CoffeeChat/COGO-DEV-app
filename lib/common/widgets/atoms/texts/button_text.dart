import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:flutter/material.dart';

final class ButtonText extends StatelessWidget {
  /// you can overriding text color (default : white)
  /// you also change alignment (default : TextAlign.center)
  /// you also select mode normal or inverted (default: normal)
  const ButtonText(
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
      style: CogoTextStyle.invertedButtonText.copyWith(
        color: color,
      ),
      textAlign: align,
    )
    :
    Text(
        data,
        style: CogoTextStyle.buttonText.copyWith(
        color: color,
    ),
    textAlign: align,
    )
    );
  }
}
final class SmallButtonText extends StatelessWidget {
  /// you can overriding text color (default : white)
  /// you also change alignment (default : TextAlign.center)
  /// you also select mode normal or inverted (default: normal)
  const SmallButtonText(
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
      style: CogoTextStyle.invertedSmallButtonText.copyWith(
        color: color,
      ),
      textAlign: align,
    )
        :
    Text(
      data,
      style: CogoTextStyle.smallButtonText.copyWith(
        color: color,
      ),
      textAlign: align,
    )
    );
  }
}

final class ModalButtonText extends StatelessWidget {
  /// you can overriding text color (default : white)
  /// you also change alignment (default : TextAlign.center)
  /// you also select mode normal or inverted (default: normal)
  const ModalButtonText(
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
      style: CogoTextStyle.invertedModalButtonText.copyWith(
        color: color,
      ),
      textAlign: align,
    )
        :
    Text(
      data,
      style: CogoTextStyle.modalButtonText.copyWith(
        color: color,
      ),
      textAlign: align,
    )
    );
  }
}

final class SelectButtonText1 extends StatelessWidget {
  /// you can overriding text color (default : white)
  /// you also change alignment (default : TextAlign.center)
  /// you should select mode true or false (default: unselected)
  const SelectButtonText1(
      this.data, {
        super.key,
        this.color,
        this.align = TextAlign.center,
        this.isSelected = false,
      });

  final String data;
  final Color? color;
  final TextAlign align;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return (isSelected?
    Text(
      data,
      style: CogoTextStyle.selectedText1.copyWith(
        color: color,
      ),
      textAlign: align,
    )
        :
    Text(
      data,
      style: CogoTextStyle.unselectedText1.copyWith(
        color: color,
      ),
      textAlign: align,
    )
    );
  }
}

final class SelectButtonText2 extends StatelessWidget {
  /// you can overriding text color (default : white)
  /// you also change alignment (default : TextAlign.center)
  /// you should select mode true or false (default: unselected)
  const SelectButtonText2(
      this.data, {
        super.key,
        this.color,
        this.align = TextAlign.center,
        this.isSelected = false,
      });

  final String data;
  final Color? color;
  final TextAlign align;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return (isSelected?
    Text(
      data,
      style: CogoTextStyle.selectedText2.copyWith(
        color: color,
      ),
      textAlign: align,
    )
        :
    Text(
      data,
      style: CogoTextStyle.unselectedText2.copyWith(
        color: color,
      ),
      textAlign: align,
    )
    );
  }
}
