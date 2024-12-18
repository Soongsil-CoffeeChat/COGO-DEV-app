import 'package:cogo/data/dto/response/my_info_response.dart';

class MyPageInfo {
  final String name;
  /// part와 club을 합친 태그 리스트
  final List<String> tags; 
  final String? picture;
  final String role;

  MyPageInfo({
    required this.name,
    required this.tags,
    required this.picture,
    required this.role,
  });

  factory MyPageInfo.fromResponse(MyInfoResponse response) {
    List<String> tags = [];
    if (response.part?.isNotEmpty ?? false) {
      tags.add(response.part!);
    }
    if (response.club?.isNotEmpty ?? false) {
      tags.add(response.club!);
    }

    return MyPageInfo(
      name: response.name,
      tags: tags,
      picture: response.picture,
      role: response.role ?? '',
    );
  }
}