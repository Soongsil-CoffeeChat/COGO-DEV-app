enum ApplicationRejectReason {
  NON_MENTORING_PURPOSE,
  DISPUTE,
  FALSE_INFORMATION,
  ABUSIVE_LANGUAGE,
  OTHER;

  String get getString {
    switch (this) {
      case ApplicationRejectReason.NON_MENTORING_PURPOSE:
        return '멘토링이 아닌 다른 목적이 있는 것 같아요';
      case ApplicationRejectReason.DISPUTE:
        return '멘토링 중에 분쟁이 발생했어요';
      case ApplicationRejectReason.FALSE_INFORMATION:
        return '멘토의 소속 및 인적사항이 거짓인 것 같아요';
      case ApplicationRejectReason.ABUSIVE_LANGUAGE:
        return '기타 부적절한 행위가 있었어요';
      case ApplicationRejectReason.OTHER:
        return '신고 세부 내용';
    }
  }

  // 한글 문자열에서 enum으로 변환 (뷰에서 받은 한글 텍스트용)
  static ApplicationRejectReason? fromDisplayString(String? displayText) {
    if (displayText == null) return null;
    try {
      return ApplicationRejectReason.values.firstWhere(
        (reason) => reason.getString == displayText,
      );
    } catch (e) {
      print('Error converting displayText: $displayText');
      return null;
    }
  }

  // 서버에서 받은 enum name 문자열로 변환
  static ApplicationRejectReason? fromServerValue(String? value) {
    if (value == null) return null;
    try {
      return ApplicationRejectReason.values.firstWhere(
        (reason) => reason.name == value,
      );
    } catch (e) {
      return null;
    }
  }
}
