enum Role {
  ROLE_MENTOR,
  ROLE_MENTEE,
  ROLE_USER,
  ROLE_ADMIN;

  String get getKorean {
    switch (this) {
      case Role.ROLE_MENTOR:
        return '멘토';
      case Role.ROLE_MENTEE:
        return '멘티';
      case Role.ROLE_USER:
        return '유저';
      case Role.ROLE_ADMIN:
        return '어드민';
    }
  }

  String get getLowercaseString {
    switch (this) {
      case Role.ROLE_MENTOR:
        return 'mentor';
      case Role.ROLE_MENTEE:
        return 'mentee';
      case Role.ROLE_USER:
        return 'user';
      case Role.ROLE_ADMIN:
        return 'admin';
    }
  }

  // Role parseRole(String? role) {
  //   return Role.values.firstWhere(
  //         (e) => e.toString().split('.').last == role,
  //     orElse: () => Role.U, // 기본값 설정 (예: guest)
  //   );
  // }
}
