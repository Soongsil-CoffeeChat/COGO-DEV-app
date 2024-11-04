import 'package:cogo/data/dto/response/mentor_part_response.dart';

class MentorPartEntity {
  final String picture;
  final String mentorName;
  final String username;
  final String mentorId;
  final String title;
  final String description;
  final List<String> tags;

  MentorPartEntity({
    required this.picture,
    required this.mentorName,
    required this.username,
    required this.mentorId,
    required this.title,
    required this.description,
    required this.tags,
  });

  factory MentorPartEntity.fromResponse(MentorPartResponse response) {
    return MentorPartEntity(
      picture: response.picture ?? '',
      mentorName: response.mentorName ?? '',
      username: response.username ?? '',
      mentorId: response.mentorId.toString(),
      title: response.title ?? '',
      description: response.description ?? '',
      tags: [
        response.club ?? '',
        response.part ?? '',
      ].where((tag) => tag.isNotEmpty).toList(), // 빈 문자열 제거
    );
  }
}
