// Content 모델 클래스
class MyInfoResponse {
  final String name;
  final String email;
  final String phoneNum;
  final String role;
  final String part;
  final String club;
  final String picture;

  MyInfoResponse({
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.role,
    required this.part,
    required this.club,
    required this.picture,
  });

  // JSON 데이터를 Content 객체로 변환
  factory MyInfoResponse.fromJson(Map<String, dynamic> json) {
    return MyInfoResponse(
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNum: json['phoneNum'] as String,
      role: json['role'] as String,
      part: json['part'] as String,
      club: json['club'] as String,
      picture: json['picture'] as String,
    );
  }

  // Content 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNum': phoneNum,
      'role': role,
      'part': part,
      'club': club,
      'picture': picture,
    };
  }
}
