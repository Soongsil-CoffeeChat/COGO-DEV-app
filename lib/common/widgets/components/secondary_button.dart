import 'dart:async';

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
  final FutureOr<void> Function()? onPressed;
  final SBSize size;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = SBSize.SMALL,
  });

  @override
  _SecondaryButtonState createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final width =
        (widget.size == BasicButtonSize.LARGE) ? _largeWidth : _smallWidth;
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: _isPressed || widget.onPressed == null
            ? null
            : () async {
                setState(() => _isPressed = true);
                await widget.onPressed!();
                if (mounted) setState(() => _isPressed = false);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isPressed ? Colors.black : CogoColor.systemGray02,
          foregroundColor: _isPressed ? Colors.white : Colors.black,
          disabledBackgroundColor: Colors.black,
          disabledForegroundColor: Colors.white,
          textStyle: CogoTextStyle.body18,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
