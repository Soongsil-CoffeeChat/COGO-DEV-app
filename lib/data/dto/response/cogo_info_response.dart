class CogoInfoResponse {
  final int applicationId;
  final String menteeName;
  final String mentorName;
  final String applicationMemo;
  final String applicationDate;
  final String applicationStartTime;
  final String applicationEndTime;

  CogoInfoResponse({
    required this.applicationId,
    required this.menteeName,
    required this.mentorName,
    required this.applicationMemo,
    required this.applicationDate,
    required this.applicationStartTime,
    required this.applicationEndTime,
  });

  factory CogoInfoResponse.fromJson(Map<String, dynamic> json) {
    return CogoInfoResponse(
      applicationId: json['application_id'],
      menteeName: json['mentee_name'],
      mentorName: json['mentor_name'],
      applicationMemo: json['application_memo'],
      applicationDate: json['application_date'],
      applicationStartTime: json['application_start_time'],
      applicationEndTime: json['application_end_time'],
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
}
