enum ReportReason {
  NON_MENTORING_PURPOSE,
  DISPUTE,
  FALSE_INFORMATION,
  ABUSIVE_LANGUAGE,
  OTHER;

  String get getString {
    switch (this) {
      case ReportReason.NON_MENTORING_PURPOSE:
        return '멘토링이 아닌 다른 목적이 있는 것 같아요';
      case ReportReason.DISPUTE:
        return '멘토링 중에 분쟁이 발생했어요';
      case ReportReason.FALSE_INFORMATION:
        return '멘토의 소속 및 인적사항이 거짓인 것 같아요';
      case ReportReason.ABUSIVE_LANGUAGE:
        return '심한 욕설이나 비속어를 사용했어요';
      case ReportReason.OTHER:
        return '기타 부적절한 행위가 있었어요';
    }
  }

  // 한글 문자열에서 enum으로 변환 (뷰에서 받은 한글 텍스트용)
  static ReportReason? fromDisplayString(String? displayText) {
    if (displayText == null) return null;
    try {
      return ReportReason.values.firstWhere(
        (reason) => reason.getString == displayText,
      );
    } catch (e) {
      print('Error converting displayText: $displayText');
      return null;
    }
  }

  // 서버에서 받은 enum name 문자열로 변환
  static ReportReason? fromServerValue(String? value) {
    if (value == null) return null;
    try {
      return ReportReason.values.firstWhere(
        (reason) => reason.name == value,
      );
    } catch (e) {
      return null;
    }
  }
}
