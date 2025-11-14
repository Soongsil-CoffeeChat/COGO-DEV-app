enum ApplicationStatus {
  MATCHED,
  UNMATCHED,
  REJECTED;

  String get getString {
    switch (this) {
      case ApplicationStatus.MATCHED:
        return 'MATCHED';
      case ApplicationStatus.UNMATCHED:
        return 'UNMATCHED';
      case ApplicationStatus.REJECTED:
        return 'REJECTED';
    }
  }
}
