import 'package:cogo/data/dto/response/application/cogo_application_response.dart';

class CogoDetailEntity {
  final int applicationId;
  final int menteeId;
  final int mentorId;
  final String applicationMemo;
  final DateTime applicationDate;
  final String applicationStartTime;
  final String applicationEndTime;

  CogoDetailEntity({
    required this.applicationId,
    required this.menteeId,
    required this.mentorId,
    required this.applicationMemo,
    required this.applicationDate,
    required this.applicationStartTime,
    required this.applicationEndTime,
  });

  factory CogoDetailEntity.fromResponse(CogoApplicationResponse response) {
    return CogoDetailEntity(
      applicationId: response.applicationId,
      menteeId: response.menteeId,
      mentorId: response.mentorId,
      applicationMemo: response.applicationMemo,
      applicationDate: DateTime.parse(response.applicationDate),
      applicationStartTime: _formatTime(response.applicationStartTime),
      applicationEndTime: _formatTime(response.applicationEndTime),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'mentee_id': menteeId,
      'mentor_id': mentorId,
      'application_memo': applicationMemo,
      'application_date': applicationDate,
      'application_start_time': applicationStartTime,
      'application_end_time': applicationEndTime,
    };
  }

  // 초 제거 메서드
  static String _formatTime(String time) {
    return time.split(':').sublist(0, 2).join(':');
  }

  String get formattedTimeSlot => '$applicationStartTime ~ $applicationEndTime';
}
