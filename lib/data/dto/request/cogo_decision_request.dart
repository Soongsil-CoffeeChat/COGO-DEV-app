class CogoDecisionRequest {
  final int applicationId;
  final String applicationStatus;

  CogoDecisionRequest({
    required this.applicationId,
    required this.applicationStatus,
  });

  factory CogoDecisionRequest.fromJson(Map<String, dynamic> json) {
    return CogoDecisionRequest(
      applicationId: json['application_id'],
      applicationStatus: json['application_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'application_status': applicationStatus,
    };
  }
}
