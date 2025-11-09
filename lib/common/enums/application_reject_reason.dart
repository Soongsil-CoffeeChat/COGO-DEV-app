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
}
