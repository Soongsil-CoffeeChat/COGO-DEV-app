import 'package:flutter/material.dart';
import 'package:cogo/constants/colors.dart';

final class CogoTextStyle{
  static const TextStyle header1 = TextStyle(
    /// mypage name
    fontFamily: "PretendardMedium",
    fontSize: 20,
    color: CogoColor.text,
  );

  static const TextStyle header2 = TextStyle(
    /// app main header
    fontFamily: "PretendardMedium",
    fontSize: 18,
    color: CogoColor.text,
  );

  static const TextStyle header3 = TextStyle(
    /// modal header
    /// mypage router header
    fontFamily: "PretendardMedium",
    fontSize: 16,
    color: CogoColor.text,
  );

  static const TextStyle caption1 = TextStyle(
    /// input caption
    fontFamily: "PretendardMedium",
    fontSize: 18,
    color: CogoColor.secondaryText,
  );

  static const TextStyle caption2 = TextStyle(
    /// app subtitle
    fontFamily: "PretendardMedium",
    fontSize: 12,
    color: CogoColor.secondaryText,
  );

  static const TextStyle caption3 = TextStyle(
    /// modal subtitle
    fontFamily: "PretendardMedium",
    fontSize: 10,
    color: CogoColor.secondaryText,
  );

  static const TextStyle text1 = TextStyle(
    fontFamily: "PretendardMedium",
    fontSize: 12,
    color: CogoColor.text,
  );

  static const TextStyle subText1 = TextStyle(
    fontFamily: "PretendardMedium",
    fontSize: 12,
    color: CogoColor.secondaryText,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: "PretendardMedium",
    fontSize: 18,
    color: CogoColor.buttonText,
  );

  static const TextStyle invertedButtonText = TextStyle(
    fontFamily: "PretendardMedium",
    fontSize: 18,
    color: CogoColor.invertedButtonText,
  );

  static const TextStyle smallButtonText = TextStyle(
    fontFamily: "PretendardMedium",
    fontSize: 12,
    color: CogoColor.buttonText,
  );

  static const TextStyle invertedSmallButtonText = TextStyle(
    fontFamily: "PretendardMedium",
    fontSize: 12,
    color: CogoColor.invertedButtonText,
  );

  static const TextStyle modalButtonText = TextStyle(
    fontFamily: "PretendardMedium",
    fontSize: 16,
    color: CogoColor.buttonText,
  );

  static const TextStyle invertedModalButtonText = TextStyle(
    fontFamily: "PretendardMedium",
    fontSize: 18,
    color: CogoColor.invertedButtonText,
  );

  static const TextStyle timerText = TextStyle(
    fontFamily: "PretendardLight",
    fontSize: 12,
    color: CogoColor.timerText,
  );

  static const TextStyle selectedText1 = TextStyle(
      fontFamily: "PretendardMedium",
      fontSize: 18,
      color: CogoColor.selectedBoxText
  );

  static const TextStyle selectedText2 = TextStyle(
    fontFamily: "PretendardMedium",
    fontSize: 12,
    color: CogoColor.selectedBoxText
  );

  static const TextStyle unselectedText1 = TextStyle(
      fontFamily: "PretendardMedium",
      fontSize: 18,
      color: CogoColor.unselectedBoxText
  );

  static const TextStyle unselectedText2 = TextStyle(
      fontFamily: "PretendardMedium",
      fontSize: 12,
      color: CogoColor.unselectedBoxText
  );

  /// Todo : Card TextStyle

  static const TextStyle cardHeader1 = TextStyle(
      fontFamily: "PretendardBold",
      fontSize: 14,
      color: CogoColor.cardHeader
  );

  static const TextStyle cardHeader2 = TextStyle(
      fontFamily: "PretendardSemiBold",
      fontSize: 10,
      color: CogoColor.cardHeader
  );

  static const TextStyle cardCaption = TextStyle(
      fontFamily: "PretendardSemiBold",
      fontSize: 10,
      color: CogoColor.cardCaption
  );

  static const TextStyle boxText = TextStyle(
    fontFamily: "PretendardMedium",
    fontSize: 10,
    color: CogoColor.sub1
  )
}
