class CogoApplicationResponse {
  final int mentorId;
  final int possibleDateId;
  final String? memo;

  CogoApplicationResponse({
    required this.mentorId,
    required this.possibleDateId,
    required this.memo,
  });

  factory CogoApplicationResponse.fromJson(Map<String, dynamic> json) {
    return CogoApplicationResponse(
      mentorId: json['mentorId'],
      possibleDateId: json['possibleDateId'],
      memo: json['memo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mentorId': mentorId,
      'possibleDateId': possibleDateId,
      'memo': memo,
    };
  }
}
