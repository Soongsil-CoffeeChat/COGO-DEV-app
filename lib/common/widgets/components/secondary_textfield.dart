import 'package:cogo/common/widgets/atoms/texts/texts.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondaryTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  /// 수정 가능 여부 체크
  final bool isEditable;

  /// inputFormatter 텍스트 포멧 형식 지정 해줌
  final List<TextInputFormatter> inputFormatters;

  const SecondaryTextfield({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
    this.isEditable = false,

    /// 기본값으로 빈 리스트로 설정
    this.inputFormatters = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: isEditable,
      inputFormatters: inputFormatters,
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
