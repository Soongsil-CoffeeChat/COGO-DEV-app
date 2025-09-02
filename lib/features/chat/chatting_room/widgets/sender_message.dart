import 'package:flutter/material.dart';

class SenderMessage extends StatelessWidget {
  final String text;
  final String time;
  final String profileUrl;

  const SenderMessage({
    super.key,
    required this.text,
    required this.time,
    required this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(radius: 16, backgroundImage: NetworkImage(profileUrl)),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(text),
          ),
        ),
        const SizedBox(width: 6),
        Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
