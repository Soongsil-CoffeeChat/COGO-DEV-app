import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.onTapPlus,
    this.isPanelOpen = false,
    this.hintText = '메시지 보내기',
    this.enabled = true,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.borderRadius = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    this.spacing = 12,
  });

  final TextEditingController controller;
  final VoidCallback? onTapPlus;
  final ValueChanged<String> onSend;

  /// true이면 × 아이콘, false이면 + 아이콘 표시
  final bool isPanelOpen;

  final String hintText;
  final bool enabled;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double spacing;

  void _handleSend() {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    onSend(text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // 추가 / 닫기 토글 버튼
            GestureDetector(
              onTap: onTapPlus,
              behavior: HitTestBehavior.opaque,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isPanelOpen
                    ? SvgPicture.asset(
                  'assets/icons/button/x.svg',
                  key: const ValueKey('close'),
                )
                    : SvgPicture.asset(
                  'assets/icons/button/plus.svg',
                  key: const ValueKey('plus'),
                ),
              ),
            ),
            SizedBox(width: spacing),

            // 입력창
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _handleSend(),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: CogoTextStyle.body16
                        .copyWith(color: CogoColor.systemGray03),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            SizedBox(width: spacing),

            // 보내기 버튼
            GestureDetector(
              onTap: _handleSend,
              behavior: HitTestBehavior.opaque,
              child: SvgPicture.asset('assets/icons/button/send.svg'),
            ),
          ],
        ),
      ),
    );
  }
}