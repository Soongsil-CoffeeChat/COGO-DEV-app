import 'package:cogo/common/widgets/atoms/image/network_image_with_fallback.dart';
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
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: NetworkImageWithFallback(
                  url: profileUrl,
                  fallbackAsset: 'assets/image/empty_chat_img.svg',
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(text),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            time,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
