import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cogo/common/widgets/atoms/texts/texts.dart';

class ProfileCard extends StatelessWidget {
  final String picture;
  final String mentorName;
  final String part;
  final String club;
  final String username;
  final String mentorId;
  final String title;
  final String description;
  final double width;
  final double height;
  final VoidCallback onTap;

  const ProfileCard({
    super.key,
    required this.picture,
    required this.mentorName,
    required this.part,
    required this.club,
    required this.username,
    required this.mentorId,
    required this.title,
    required this.description,
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
                    picture,
                    width: double.infinity,
                    height: 150, // 이미지 높이
                    fit: BoxFit.cover, // 이미지 꽉 채우기
                  ),
                ),
                // 클럽과 파트 값을 이미지 위에 배치
                Positioned(
                  top: 15,
                  left: 15,
                  child: Row(
                    children: [
                      _buildTag(club),
                      const SizedBox(width: 8),
                      _buildTag(part),
                    ],
                  ),
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
                    '$mentorName 멘토님',
                    style: CogoTextStyle.body20,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
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

  Widget _buildTag(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: CogoTextStyle.body12.copyWith(color: CogoColor.white50),
        ),
      ),
    );
  }
}