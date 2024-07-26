import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String info;
  final double? width;

  InfoBox({required this.info, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // width 파라미터 사용
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        info,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'PretendardMedium',
          fontSize: 18,
        ),
      ),
    );
  }
}
