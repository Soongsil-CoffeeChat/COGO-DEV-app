class MentorIntroductionResponse {
  final String? introductionTitle;
  final String? introductionDescription;
  final String? introductionAnswer1;
  final String? introductionAnswer2;

  MentorIntroductionResponse({
    required this.introductionTitle,
    required this.introductionDescription,
    required this.introductionAnswer1,
    required this.introductionAnswer2,
  });

  factory MentorIntroductionResponse.fromJson(Map<String, dynamic> json) {
    return MentorIntroductionResponse(
      introductionTitle: json['introductionTitle'],
      introductionDescription: json['introductionDescription'],
      introductionAnswer1: json['introductionAnswer1'],
      introductionAnswer2: json['introductionAnswer2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'introductionTitle': introductionTitle,
      'introductionDescription': introductionDescription,
      'introductionAnswer1': introductionAnswer1,
      'introductionAnswer2': introductionAnswer2,
    };
  }
}
