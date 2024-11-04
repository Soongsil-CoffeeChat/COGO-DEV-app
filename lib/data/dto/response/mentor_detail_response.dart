class MentorDetailResponse {
  final int mentorId;
  final String? mentorName;
  final String? part;
  final String? club;
  final String? introductionTitle;
  final String? introductionDescription;
  final String? introductionAnswer1;
  final String? introductionAnswer2;
  final String? imageUrl;

  MentorDetailResponse({
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

  factory MentorDetailResponse.fromJson(Map<String, dynamic> json) {
    return MentorDetailResponse(
      mentorId: json['mentorId'],
      mentorName: json['mentorName'],
      part: json['part'],
      club: json['club'],
      introductionTitle: json['introductionTitle'],
      introductionDescription: json['introductionDescription'],
      introductionAnswer1: json['introductionAnswer1'],
      introductionAnswer2: json['introductionAnswer2'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mentorId': mentorId,
      'mentorName': mentorName,
      'part': part,
      'club': club,
      'introductionTitle': introductionTitle,
      'introductionDescription': introductionDescription,
      'introductionAnswer1': introductionAnswer1,
      'introductionAnswer2': introductionAnswer2,
      'imageUrl': imageUrl,
    };
  }
}
