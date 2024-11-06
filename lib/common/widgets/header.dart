import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBackButtonPressed;

  Header({
    required this.title,
    required this.subtitle,
    required this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          //padding: const EdgeInsets.symmetric(vertical: 15), // 위 아래 패딩 10
          child: IconButton(
            icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'),
            onPressed: onBackButtonPressed,
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft, // 왼쪽 정렬
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0), // 왼쪽 정렬을 위한 패딩 값
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: CogoTextStyle.body18),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: CogoTextStyle.body12
                      .copyWith(color: CogoColor.systemGray03)),
            ],
          ),
        ),
      ],
    );
  }
}
