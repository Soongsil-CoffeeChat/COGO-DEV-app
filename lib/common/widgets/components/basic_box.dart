import 'package:cogo/common/widgets/atoms/texts/texts.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

class BasicBox extends StatelessWidget {
  final String info;
  final double? width;

  BasicBox({required this.info, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        info,
        style: CogoTextStyle.body18.copyWith(color: CogoColor.white50),
      ),
    );
  }
}
