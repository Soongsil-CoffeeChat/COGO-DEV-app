import 'package:cogo/data/dto/response/mentor_introduction_response.dart';

class MyMentorEntity {
  final String introductionTitle;
  final String introductionDescription;
  final String introductionAnswer1;
  final String introductionAnswer2;

  MyMentorEntity({
    required this.introductionTitle,
    required this.introductionDescription,
    required this.introductionAnswer1,
    required this.introductionAnswer2,
  });

  factory MyMentorEntity.fromResponse(MentorIntroductionResponse response) {
    return MyMentorEntity(
      introductionTitle: response.introductionTitle ?? '',
      introductionDescription: response.introductionDescription ?? '',
      introductionAnswer1: response.introductionAnswer1 ?? '',
      introductionAnswer2: response.introductionAnswer2 ?? '',
    );
  }
}
