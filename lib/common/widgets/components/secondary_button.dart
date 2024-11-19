import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  /// 표시할 텍스트
  final String text;

  /// 눌렀을 때 실행할 콜백
  final VoidCallback? onPressed;

  /// 버튼의 너비 (small, large)
  final String width;

  const SecondaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width = 'small',
  }) : super(key: key);

  @override
  _SecondaryButtonState createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  /// 버튼의 내부 상태 관리
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    /// large, small에 따른 버튼 너비 설정
    return widget.width == 'large'
        ? Expanded(
            child: _buildButton(double.infinity), // 부모에 맞춰 너비 확장
          )
        : SizedBox(
            width: 150, // small일 때 고정 너비
            child: _buildButton(150),
          );
  }

  Widget _buildButton(double width) {
    return ElevatedButton(
      onPressed: () {
        /// 콜백 실행시 _isPressed 상태 변경
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
        shadowColor: Colors.transparent, // 그림자를 제거
        minimumSize: Size(width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(widget.text),
    );
  }
}
