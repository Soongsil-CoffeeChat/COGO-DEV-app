import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/button_size.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;

  const SecondaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.size = const SmallButtonSize(), // 기본값 small
  }) : super(key: key);

  @override
  _SecondaryButtonState createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  /// 버튼의 내부 상태 관리
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      child: _buildButton(widget.size.width),
    );
  }

  Widget _buildButton(double width) {
    return ElevatedButton(
      onPressed: () {
        /// 콜백 실행 시 _isPressed 상태 변경
        setState(() {
          _isPressed = !_isPressed;
        });

        /// 외부 onPressed 콜백 실행
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isPressed ? Colors.black : CogoColor.systemGray02,
        foregroundColor: _isPressed ? Colors.white : Colors.black,
        textStyle: CogoTextStyle.body18,
        shadowColor: Colors.transparent,
        minimumSize: Size(width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(widget.text),
    );
  }
}
