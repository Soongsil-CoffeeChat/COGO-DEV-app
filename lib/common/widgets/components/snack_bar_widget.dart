import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

class SnackbarWidgt {
  static void show(BuildContext context, String text) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(text, style: CogoTextStyle.body14),
        backgroundColor: CogoColor.white50,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
