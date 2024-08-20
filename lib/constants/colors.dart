import 'package:flutter/material.dart';

final class CogoColor {
  // Brand Color
  static const main = Color(0xFF000000);
  static const sub1 = Color(0xFFFFFFFF);

  // Semantic Color
  static const text = main;
  static const invertedText = sub1;
  static const secondaryText = Color(0xFFAEAEB2);

  // Tab Colors
  static const tabText = sub1;
  static const tabText2 = Color(0xFF626262); // unselected

  // Button Colors : Button Text
  static const buttonText = sub1;
  static const invertedButtonText = main;

  // Button Colors : Button Background
  static const buttonBackground = main;
  static const invertedButtonBackground = sub1;
  static const secondaryButtonBackground = Color(0xFFEDEDED);

  // Selected Box Colors
  static const selectedBoxText = sub1;
  static const selectBoxBackground = main;

  // Unselected Box Colors
  static const unselectedBoxText = Color(0xFF8f8f8f);
  static const unselectedBoxBackground = Color(0xFFFFFFFF);
  static const secondaryUnselectedBoxBackground = Color(0xFFC1C1C1);

  // Card Colors
  static const cardHeader = Color(0xFF000000);
  static const cardCaption= Color(0xFF606060);

  // Backgrounds
  static const background = Color(0xFFFFFFFF);
  static const secondaryBackground = Color(0xFFF6F6F6);
  static const inputBackground = Color(0xFFF4F4F4);


  static const shadow = Colors.black12;
  static const imagePlaceholder = Color(0xFFD9D9D9);
  static const timerText = Color(0xFFFF4949);
}
