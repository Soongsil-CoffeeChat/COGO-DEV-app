class CheckEligibilityResponse {
  final bool canIssue;
  final bool alreadyIssued;
  final bool limitExceeded;

  CheckEligibilityResponse({
    required this.canIssue,
    required this.alreadyIssued,
    required this.limitExceeded,
  });

  factory CheckEligibilityResponse.fromJson(Map<String, dynamic> json) {
    return CheckEligibilityResponse(
      canIssue: json['canIssue'] as bool,
      alreadyIssued: json['alreadyIssued'] as bool,
      limitExceeded: json['limitExceeded'] as bool,
    );
  }
}
