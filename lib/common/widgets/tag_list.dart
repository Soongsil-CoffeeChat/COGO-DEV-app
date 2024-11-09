import 'package:flutter/material.dart';

import 'components/tag.dart';

class TagList extends StatelessWidget {
  final List<String> tags;

  const TagList({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
      children: tags
          .map((tag) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Tag(title: tag),
              ))
          .toList(),
    );
  }
}
