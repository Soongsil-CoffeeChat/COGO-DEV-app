import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String clubName;
  final List<String> tags;
  final String description;

  const ProfileCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.clubName,
    required this.tags,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'PretendardBold',
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '아픈건 딱 질색이니까',
                      style: TextStyle(
                        fontFamily: 'PretendardSemiBold',
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        fontFamily: 'PretendardLight',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(imagePath),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                clubName,
                style: const TextStyle(
                  fontFamily: 'PretendardMedium',
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Row(
                children: tags.map((tag) => _buildTag(tag)).toList(),
              ),
            ],
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
