enum Role {
  MENTOR,
  MENTEE,
  USER;

  String get getKorean {
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

  // Role parseRole(String? role) {
  //   return Role.values.firstWhere(
  //         (e) => e.toString().split('.').last == role,
  //     orElse: () => Role.U, // 기본값 설정 (예: guest)
  //   );
  // }
}