import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

/// Size enum
enum SBSize {
  SMALL,
  LARGE,
}

const double _smallWidth = 170;
const double _largeWidth = double.infinity;

class SecondaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final SBSize size;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = SBSize.SMALL, // 기본값 small
  });

  @override
  _SecondaryButtonState createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  /// 버튼의 내부 상태 관리
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final width =
        (widget.size == BasicButtonSize.LARGE) ? _largeWidth : _smallWidth;
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          /// 콜백 실행 시 _isPressed 상태 변경
          setState(() {
            _isPressed = !_isPressed;
          });

          /// 외부 onPressed 콜백 실행
          widget.onPressed?.call();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isPressed ? Colors.black : CogoColor.systemGray02,
          foregroundColor: _isPressed ? Colors.white : Colors.black,
          textStyle: CogoTextStyle.body18,
          shadowColor: Colors.transparent,
          // minimumSize: Size(width, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
