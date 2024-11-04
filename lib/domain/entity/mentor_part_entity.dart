import 'package:cogo/data/dto/response/mentor_part_response.dart';

class MentorPartEntity {
  final String picture;
  final String mentorName;
  final String part;
  final String club;
  final String username;
  final String mentorId;
  final String title;
  final String description;

  MentorPartEntity({
    required this.picture,
    required this.mentorName,
    required this.part,
    required this.club,
    required this.username,
    required this.mentorId,
    required this.title,
    required this.description,
  });

  factory MentorPartEntity.fromResponse(MentorPartResponse response) {
    return MentorPartEntity(
      picture: response.picture ?? '',
      mentorName: response.mentorName ?? '',
      part: response.part ?? '',
      club: response.club ?? '',
      username: response.username ?? '',
      mentorId: response.mentorId.toString(),
      title: response.title ?? '',
      description: response.description ?? '',
    );
  }
}
