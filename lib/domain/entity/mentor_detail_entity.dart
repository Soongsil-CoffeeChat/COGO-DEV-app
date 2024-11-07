import 'package:cogo/data/dto/response/mentor_detail_response.dart';

class MentorDetailEntity {
  final int mentorId;
  final String mentorName;
  final String part;
  final String club;
  final String introductionTitle;
  final String introductionDescription;
  final String introductionAnswer1;
  final String introductionAnswer2;
  final String imageUrl;

  MentorDetailEntity({
    required this.mentorId,
    required this.mentorName,
    required this.part,
    required this.club,
    required this.introductionTitle,
    required this.introductionDescription,
    required this.introductionAnswer1,
    required this.introductionAnswer2,
    required this.imageUrl,
  });

  factory MentorDetailEntity.fromResponse(MentorDetailResponse response) {
    return MentorDetailEntity(
      mentorId: response.mentorId,
      mentorName: response.mentorName ?? '',
      part: response.part ?? '',
      club: response.club ?? '',
      introductionTitle: response.introductionTitle ?? '',
      introductionDescription: response.introductionDescription ?? '',
      introductionAnswer1: response.introductionAnswer1 ?? '',
      introductionAnswer2: response.introductionAnswer2 ?? '',
      imageUrl: response.imageUrl ?? '',
    );
  }
}
