class MentorSignupResponse {
  final String part;
  final String club;
  final int introductionId;

  MentorSignupResponse({
    required this.part,
    required this.club,
    required this.introductionId,
  });

  // JSON 데이터를 MentorSignupResponse 객체로 변환
  factory MentorSignupResponse.fromJson(Map<String, dynamic> json) {
    return MentorSignupResponse(
      part: json['part'] as String,
      club: json['club'] as String,
      introductionId: json['introductionId'] as int,
    );
  }

  // MentorSignupResponse 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'part': part,
      'club': club,
      'introductionId': introductionId,
    };
  }
}
