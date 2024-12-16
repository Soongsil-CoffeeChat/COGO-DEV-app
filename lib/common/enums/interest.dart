enum Interest {
  FE,
  BE,
  MOBILE,
  PM,
  DESIGN;

  /// 문자열 라벨 반환
  String get label {
    switch (this) {
      case Interest.FE:
        return 'FE';
      case Interest.BE:
        return 'BE';
      case Interest.MOBILE:
        return 'MOBILE';
      case Interest.PM:
        return 'PM';
      case Interest.DESIGN:
        return 'DESIGN';
    }
  }
}
