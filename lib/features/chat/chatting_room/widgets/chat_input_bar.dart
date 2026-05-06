import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatInputBar extends StatefulWidget {
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

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _handleSend() {
    final text = widget.controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    widget.controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // 추가 / 닫기 토글 버튼
            GestureDetector(
              onTap: widget.onTapPlus,
              behavior: HitTestBehavior.opaque,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: widget.isPanelOpen
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
            SizedBox(width: widget.spacing),

            // 입력창
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: TextField(
                  controller: widget.controller,
                  enabled: widget.enabled,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _handleSend(),
                  style: CogoTextStyle.body14,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: CogoTextStyle.body14
                        .copyWith(color: CogoColor.systemGray03),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ),
              ),
            ),
            SizedBox(width: widget.spacing),

            // 보내기 버튼
            GestureDetector(
              onTap: _handleSend,
              behavior: HitTestBehavior.opaque,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: SvgPicture.asset(
                  _hasText
                      ? 'assets/icons/button/send_on.svg'
                      : 'assets/icons/button/send.svg',
                  key: ValueKey(_hasText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
