class MentorIntroductionResponse {
  final String introductionTitle;
  final String introductionDescription;
  final String introductionAnswer1;
  final String introductionAnswer2;

  MentorIntroductionResponse({
    required this.introductionTitle,
    required this.introductionDescription,
    required this.introductionAnswer1,
    required this.introductionAnswer2,
  });

  factory MentorIntroductionResponse.fromJson(Map<String, dynamic> json) {
    return MentorIntroductionResponse(
      introductionTitle: json['introduction_title'],
      introductionDescription: json['introduction_description'],
      introductionAnswer1: json['introduction_answer1'],
      introductionAnswer2: json['introduction_answer2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'introduction_title': introductionTitle,
      'introduction_description': introductionDescription,
      'introduction_answer1': introductionAnswer1,
      'introduction_answer2': introductionAnswer2,
    };
  }
}
