class CogoDecisionRequest {
  final int applicationId;
  final String applicationStatus;
  final String? reason;

  CogoDecisionRequest({
    required this.applicationId,
    required this.applicationStatus,
    required this.reason,
  });

  factory CogoDecisionRequest.fromJson(Map<String, dynamic> json) {
    return CogoDecisionRequest(
      applicationId: json['application_id'],
      applicationStatus: json['application_status'],
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'application_status': applicationStatus,
      'reason': reason,
    };
  }
}
