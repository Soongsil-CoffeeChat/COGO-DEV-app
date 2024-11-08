class MentorPossibleDateResponse {
  final int possiblDateId;
  final String date;
  final String startTime;
  final String endTime;

  MentorPossibleDateResponse({
    required this.possiblDateId,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory MentorPossibleDateResponse.fromJson(Map<String, dynamic> json) {
    return MentorPossibleDateResponse(
      possiblDateId: json['possible_date_id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'possible_date_id': possiblDateId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
