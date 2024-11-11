import 'package:cogo/data/dto/response/requested_cogo_response.dart';

class RequestedCogoEntity {
  final int applicationId;
  final String menteeName;
  final String mentorName;
  final String applicationMemo;
  final DateTime applicationDate;
  final String applicationStartTime;
  final String applicationEndTime;

  RequestedCogoEntity({
    required this.applicationId,
    required this.menteeName,
    required this.mentorName,
    required this.applicationMemo,
    required this.applicationDate,
    required this.applicationStartTime,
    required this.applicationEndTime,
  });

  factory RequestedCogoEntity.fromResponse(RequestedCogoResponse response) {
    return RequestedCogoEntity(
      applicationId: response.applicationId,
      menteeName: response.menteeName,
      mentorName: response.mentorName,
      applicationMemo: response.applicationMemo,
      applicationDate: DateTime.parse(response.applicationDate),
      applicationStartTime: _formatTime(response.applicationStartTime),
      applicationEndTime: _formatTime(response.applicationEndTime),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'mentee_name': menteeName,
      'mentor_name': mentorName,
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
