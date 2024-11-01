class MentorDetailResponse {
  final String mentorId;
  final String mentorName;
  final String part;
  final String club;
  final String introductionTitle;
  final String introductionDescription;
  final String introductionAnswer1;
  final String introductionAnswer2;
  final String imageUrl;

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
      mentorId: json['mentorId'].toString(),
      mentorName: json['mentorName'] as String,
      part: json['part'] as String,
      club: json['club'] as String,
      introductionTitle: json['introductionTitle'] as String,
      introductionDescription: json['introductionDescription'] as String,
      introductionAnswer1: json['introductionAnswer1'] as String,
      introductionAnswer2: json['introductionAnswer2'] as String,
      imageUrl: json['imageUrl'] as String,
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

  @override
  String toString() {
    return 'MentorDetailResponse{mentorId: $mentorId, '
        'mentorName: $mentorName, '
        'part: $part, '
        'club: $club, '
        'introductionTitle: $introductionTitle, '
        'introductionDescription: $introductionDescription, '
        'introductionAnswer1: $introductionAnswer1, '
        'introductionAnswer2: $introductionAnswer2, '
        'imageUrl: $imageUrl}';
  }
}
