enum Club {
  GDGoC,
  YOURSSU,
  UMC,
  LIKELION,
  NO_CLUB;

  /// 버튼 등 UI에 표시할 텍스트
  String get label {
    if (this == Club.NO_CLUB) return 'NO CLUB';
    return name;
  }

  /// SecureStorage/서버에 저장·전송할 값 (enum name 그대로 사용)
  String get serverValue => name;

  /// 서버값 → 표시 레이블 변환
  static String labelFromServerValue(String? value) {
    if (value == null) return '동아리';
    try {
      return Club.values.firstWhere((c) => c.name == value).label;
    } catch (_) {
      return value;
    }
  }
}
