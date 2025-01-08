import 'package:cogo/common/widgets/atoms/texts/texts.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

class SecondaryTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const SecondaryTextfield({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: CogoTextStyle.body18,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: CogoTextStyle.body12.copyWith(
          color: CogoColor.systemGray03,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
