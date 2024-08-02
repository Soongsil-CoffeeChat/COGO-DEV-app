import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String clubName;
  final List<String> tags;
  final double width;
  final double height;

  const ProfileCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.clubName,
    required this.tags,
    this.width = 220,
    this.height = 280,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60, // 반지름, 총 원의 크기는 120
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'PretendardMedium',
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tags.map((tag) => _buildTag(tag)).toList(),
          ),
        ],
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
          style: const TextStyle(
            fontFamily: 'PretendardMedium',
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
