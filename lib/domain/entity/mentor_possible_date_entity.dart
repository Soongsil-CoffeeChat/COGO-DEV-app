class MentorPossibleDateEntity {
  final DateTime date;
  final String startTime;
  final String endTime;

  MentorPossibleDateEntity({
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory MentorPossibleDateEntity.fromJson(Map<String, dynamic> json) {
    return MentorPossibleDateEntity(
      date: DateTime.parse(json['date']),
      startTime: _formatTime(json['start_time']),
      endTime: _formatTime(json['end_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  // 시간 문자열에서 초를 제거 메서드
  static String _formatTime(String time) {
    return time.split(':').sublist(0, 2).join(':');
  }

  // 날짜 포맷을 위한 메서드
  String get formattedDate => '${date.year}-${date.month}-${date.day}';

  // 시간대를 결합한 포맷
  String get formattedTimeSlot => '$startTime ~ $endTime';
}
