import 'package:cogo/domain/entity/my_page_info.dart';

class MyInfoResponse {
  final String name;
  final String? email;
  final String? phoneNum;
  final String role;
  final String part;
  final String? club;
  final String? picture;

  MyInfoResponse({
    required this.name,
    this.email,
    this.phoneNum,
    required this.role,
    required this.part,
    this.club,
    this.picture,
  });

  // JSON 데이터를 Content 객체로 변환
  factory MyInfoResponse.fromJson(Map<String, dynamic> json) {
    return MyInfoResponse(
      name: json['name'] as String,
      email: json['email'] as String?,
      phoneNum: json['phoneNum'] as String?,
      role: json['role'] as String,
      part: json['part'] as String,
      club: json['club'] as String?,
      picture: json['picture'] as String?,
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

  MyPageInfo toMyPageInfo() {
    // tags 리스트에 part와 club이 null이 아닐 경우만 추가
    List<String> tags = [];
    if (part.isNotEmpty) {
      tags.add(part);
    }
    if (club?.isNotEmpty ?? false) {
      tags.add(club!);
    }

    return MyPageInfo(
      name: name,
      tags: tags, // 조건에 맞게 추가된 tag들만 포함
      picture: picture ?? '', // picture가 null이면 빈 문자열로 대체
    );
  }
}
