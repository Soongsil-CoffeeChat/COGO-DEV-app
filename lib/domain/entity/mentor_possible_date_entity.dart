import 'package:cogo/data/dto/response/mentor_possible_date_response.dart';

class MentorPossibleDateEntity {
  final int possibleDateId;
  final DateTime date;
  final String startTime;
  final String endTime;

  MentorPossibleDateEntity({
    required this.possibleDateId,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory MentorPossibleDateEntity.fromResponse(
      MentorPossibleDateResponse response) {
    return MentorPossibleDateEntity(
      possibleDateId: response.possibleDateId,
      date: DateTime.parse(response.date),
      startTime: _formatTime(response.startTime),
      endTime: _formatTime(response.endTime),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'possible_date_id': possibleDateId,
      'date': date.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  // 초 제거 메서드
  static String _formatTime(String time) {
    return time.split(':').sublist(0, 2).join(':');
  }

  String get formattedTimeSlot => '$startTime ~ $endTime';
}
