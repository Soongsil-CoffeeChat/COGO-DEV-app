import 'package:flutter/material.dart';

class ReceiverMessage extends StatelessWidget {
  final String text;
  final String time;
  final bool isRead;

  const ReceiverMessage({
    super.key,
    required this.text,
    required this.time,
    this.isRead = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isRead)
          const Text('읽음', style: TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(width: 6),
        Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(width: 6),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF338DFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
