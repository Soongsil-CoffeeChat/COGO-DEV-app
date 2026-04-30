import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

class InlineErrorMessage extends StatelessWidget {
  final String? message;

  const InlineErrorMessage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        message!,
        style: CogoTextStyle.body14.copyWith(color: CogoColor.systemRed),
        textAlign: TextAlign.center,
      ),
    );
  }
}
