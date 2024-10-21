class MenteeSignupResponse {
  final String part;

  MenteeSignupResponse({
    required this.part,
  });

  // JSON 데이터를 MentorSignupResponse 객체로 변환
  factory MenteeSignupResponse.fromJson(Map<String, dynamic> json) {
    return MenteeSignupResponse(
      part: json['part'] as String,
    );
  }

  // MentorSignupResponse 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'part': part,
    };
  }
}
