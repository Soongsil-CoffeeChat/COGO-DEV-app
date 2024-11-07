class ApplyCogoResponse {
  final int mentorId;
  final int possibleDateId;
  final String? memo;

  ApplyCogoResponse({
    required this.mentorId,
    required this.possibleDateId,
    required this.memo,
  });

  factory ApplyCogoResponse.fromJson(Map<String, dynamic> json) {
    return ApplyCogoResponse(
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
