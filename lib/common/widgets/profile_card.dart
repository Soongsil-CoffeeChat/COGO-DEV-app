import 'package:cogo/common/widgets/atoms/texts/texts.dart';
import 'package:flutter/material.dart';

import 'tag.dart';

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String tittle;
  final String description;
  final String clubName;
  final List<String> tags;
  final double width;
  final double height;
  final VoidCallback onTap;

  const ProfileCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.tittle,
    required this.description,
    required this.clubName,
    required this.tags,
    this.width = 150,
    this.height = 280,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(10, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지와 태그를 겹쳐서 배치하기 위한 Stack 사용
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 150, // 이미지 높이
                    fit: BoxFit.cover, // 이미지 꽉 채우기
                  ),
                ),
                // 태그 리스트를 이미지 위에 배치
                Positioned(
                  top: 15, // 이미지 위에서 10px 아래에 배치
                  left: 15, // 이미지 왼쪽에서 10px 오른쪽에 배치
                  child: Tag(tags: tags), // 태그 리스트를 새로운 위젯으로 교체
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    '$name 멘토님',
                    style: CogoTextStyle.body20,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tittle,
                    style: CogoTextStyle.body14,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: CogoTextStyle.body12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
