import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

import 'atoms/texts/styles.dart';

class Tag extends StatelessWidget {
  final List<String> tags;

  const Tag({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: tags.map((tag) => _buildTag(tag)).toList(),
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
