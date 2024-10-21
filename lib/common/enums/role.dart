enum Role {
  MENTOR,
  MENTEE,
  USER;

  String get getDisplayString {
    switch (this) {
      case Role.MENTOR:
        return '멘토';
      case Role.MENTEE:
        return '멘티';
      case Role.USER:
        return '유저';
    }
  }

  String get getLowercaseString {
    switch (this) {
      case Role.MENTOR:
        return 'mentor';
      case Role.MENTEE:
        return 'mentee';
      case Role.USER:
        return 'user';
    }
  }
}
