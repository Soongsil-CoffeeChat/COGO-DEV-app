import 'package:cogo/common/widgets/atoms/texts/texts.dart';
import 'package:cogo/common/widgets/tag_list.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String picture;
  final String mentorName;
  final String username;
  final String mentorId;
  final List<String> tags;
  final String title;
  final String description;
  final double width;
  final double height;
  final VoidCallback onTap;

  const ProfileCard({
    super.key,
    required this.picture,
    required this.mentorName,
    required this.tags,
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
          color: CogoColor.white50,
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                    child: Image.network(
                      picture.isNotEmpty ? picture : '', // 빈 문자열로 설정해 에러를 유도
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/default_img.png', // 로컬 기본 이미지
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        );
                      },
                    )),
                Positioned(
                  top: 15,
                  left: 15,
                  child: TagList(tags: tags), // 태그 리스트를 새로운 위젯으로 교체
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
}
