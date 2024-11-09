class MentorPossibleDateResponse {
  final int possibleDateId;
  final String date;
  final String startTime;
  final String endTime;

  MentorPossibleDateResponse({
    required this.possibleDateId,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory MentorPossibleDateResponse.fromJson(Map<String, dynamic> json) {
    return MentorPossibleDateResponse(
      possibleDateId: json['possible_date_id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'possible_date_id': possibleDateId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
