enum AccountStatus {
  NEW_ACCOUNT,
  EXISTING_ACCOUNT,
  RESTORED_ACCOUNT;

  String get getString {
    switch (this) {
      case AccountStatus.NEW_ACCOUNT:
        return 'NEW_ACCOUNT';
      case AccountStatus.EXISTING_ACCOUNT:
        return 'EXISTING_ACCOUNT';
      case AccountStatus.RESTORED_ACCOUNT:
        return 'RESTORED_ACCOUNT';
    }
  }
}
