import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttachmentPanel extends StatelessWidget {
  const AttachmentPanel({
    super.key,
    required this.onImageTap,
    required this.onCouponTap,
  });

  final VoidCallback onImageTap;
  final VoidCallback onCouponTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AttachmentItem(
            assetPath: 'assets/icons/button/img.svg',
            label: '이미지',
            onTap: onImageTap,
          ),
          const SizedBox(width: 30),
          AttachmentItem(
            assetPath: 'assets/icons/button/slot.svg',
            label: '커피쿠폰\n발급 받기',
            onTap: onCouponTap,
          ),
        ],
      ),
    );
  }
}

class AttachmentItem extends StatelessWidget {
  const AttachmentItem({
    super.key,
    required this.assetPath,
    required this.label,
    required this.onTap,
  });

  final String assetPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: SvgPicture.asset(
                assetPath,
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: CogoTextStyle.body14.copyWith(color: CogoColor.systemGray04),
          ),
        ],
      ),
    );
  }
}
