class UserInfoResponse {
  final String username;
  final String name;
  final String email;
  final String role;
  final String phoneNum;
  final String picture;

  UserInfoResponse({
    required this.username,
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNum,
    required this.picture,
  });

  // JSON 데이터를 UserResponse 객체로 변환
  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
      username: json['username'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      phoneNum: json['phoneNum'] as String,
      picture: json['picture'] as String,
    );
  }

  // UserResponse 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'role': role,
      'phoneNum': phoneNum,
      'picture': picture,
    };
  }
}
