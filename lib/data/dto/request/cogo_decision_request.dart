class CogoDecisionRequest {
  final int applicationId;
  final String applicationStatus;
  final String? reason;

  CogoDecisionRequest({
    required this.applicationId,
    required this.applicationStatus,
    this.reason,
  });

  factory CogoDecisionRequest.fromJson(Map<String, dynamic> json) {
    return CogoDecisionRequest(
      applicationId: json['applicationId'],
      applicationStatus: json['applicationStatus'],
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'applicationId': applicationId,
      'applicationStatus': applicationStatus,
      'reason': reason,
    };
  }
}
