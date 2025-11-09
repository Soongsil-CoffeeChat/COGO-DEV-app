enum ApplicationRejectReason {
  SHEDULE_ISSUE,
  QUESTION_DIFFICULTY,
  ANOTHER_AREA,
  NO_AFFORD,
  HEALTH_PROBLEM,
  OTHER;

  String get getString {
    switch (this) {
      case ApplicationRejectReason.SHEDULE_ISSUE:
        return '시간이 맞지 않음';
      case ApplicationRejectReason.QUESTION_DIFFICULTY:
        return '멘티의 질문에 답하기 어려움';
      case ApplicationRejectReason.ANOTHER_AREA:
        return '현재 다른지역에 있음';
      case ApplicationRejectReason.NO_AFFORD:
        return '커피챗을 할 여유가 없음(자격증, 취업준비 등)';
      case ApplicationRejectReason.HEALTH_PROBLEM:
        return '건강이 좋지 않음';
      case ApplicationRejectReason.OTHER:
        return '기타사유 입력';
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
